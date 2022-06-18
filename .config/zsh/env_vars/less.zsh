
# Enables various options for less.
# --RAW-CONTROL-CHARS,
#     respects ANSI color codes
# --ignore-case,
#     Causes searches to ignore case; that is, uppercase and
#     lowercase are considered identical.  This option is
#     ignored if any uppercase letters appear in the search
#     pattern; in other words, if a pattern contains uppercase
#     letters, then that search does not ignore case.
# --underline-special,
#     Causes backspaces and carriage returns to be treated as
#     printable characters; that is, they are sent to the
#     terminal when they appear in the input.
# --follow-name,
#     Normally, if the input file is renamed while an F command
#     is executing, less will continue to display the contents
#     of the original file despite its name change.  If
#     --follow-name is specified, during an F command less will
#     periodically attempt to reopen the file by name.  If the
#     reopen succeeds and the file is a different file from the
#     original (which means that a new file has been created
#     with the same name as the original (now renamed) file),
#     less will display the contents of that new file.
# --mouse,
#    Enables mouse input: scrolling the mouse wheel down moves
#    forward in the file, scrolling the mouse wheel up moves
#    backwards in the file, and clicking the mouse sets the "#"
#    mark to the line where the mouse is clicked.
export LESS='--RAW-CONTROL-CHARS --ignore-case --underline-special --follow-name --mouse'
