local selected_or_hovered = ya.sync(function()
	local tab, paths = cx.active, {}
	for _, u in pairs(tab.selected) do
		paths[#paths + 1] = tostring(u)
	end
	if #paths == 0 and tab.current.hovered then
		paths[1] = tostring(tab.current.hovered.url)
	end
	return paths
end)

-- Position input based on whether items are selected or hovered
local dynamic_input_position = ya.sync(function()
	local tab, paths = cx.active, {}

	-- Get hovered item
	local hovered_url
	if tab.current.hovered then
		hovered_url = tostring(tab.current.hovered.url)
	end
	-- Get list of selected items
	local selected_paths = {}
	for _, u in pairs(tab.selected) do
		selected_paths[#selected_paths + 1] = tostring(u)
	end

	local position
	if #selected_paths == 0 and tab.current.hovered then
		-- No selected item, show under the hovered item
		position = { "hovered", y = 1, w = 50 }
	elseif #selected_paths == 1 and selected_paths[1] == hovered_url then
		-- Single selected item and is currently hovered, show under the hovered item
		position = { "hovered", y = 1, w = 50 }
	else
		-- Multiple items selected or single item selected that is not hovered (also a default value)
		-- show in the top center (same default position as many other input scenarios)
		position = { "top-center", y = 2, w = 50 }
	end
	return position
end)


return {
	entry = function()
		ya.manager_emit("escape", { visual = true })

		local urls = selected_or_hovered()
		if #urls == 0 then
			return ya.notify { title = "Chmod", content = "No file selected", level = "warn", timeout = 5 }
		end

		local value, event = ya.input {
			title = "Chmod:",
			position = dynamic_input_position(),
		}
		if event ~= 1 then
			return
		end

		local status, err = Command("chmod"):arg(value):args(urls):spawn():wait()
		if not status or not status.success then
			ya.notify {
				title = "Chmod",
				content = string.format("Chmod with selected files failed, exit code %s", status and status.code or err),
				level = "error",
				timeout = 5,
			}
		end
	end,
}
