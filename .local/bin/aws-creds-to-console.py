################################################################
#
# Modified version, taken from: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-custom-url.html#STSConsoleLink_programPython
#
################################################################

import urllib
import json
import sys
import requests  # 'pip install requests'
import os

sessionId = os.getenv("AWS_ACCESS_KEY_ID")
sessionKey = os.getenv("AWS_SECRET_ACCESS_KEY")
sessionToken = os.getenv("AWS_SESSION_TOKEN")

url_credentials = {}
url_credentials["sessionId"] = sessionId
url_credentials["sessionKey"] = sessionKey
if sessionToken != "":
    url_credentials["sessionToken"] = sessionToken
json_string_with_temp_credentials = json.dumps(url_credentials)

# Step 4. Make request to AWS federation endpoint to get sign-in token. Construct the parameter string with
# the sign-in action request, a 12-hour session duration, and the JSON document with temporary credentials
# as parameters.
request_parameters = "?Action=getSigninToken"
request_parameters += "&SessionDuration=43200"
if sys.version_info[0] < 3:

    def quote_plus_function(s):
        return urllib.quote_plus(s)

else:

    def quote_plus_function(s):
        return urllib.parse.quote_plus(s)


request_parameters += "&Session=" + quote_plus_function(
    json_string_with_temp_credentials
)
if os.getenv("AWS_REGION", "ap-southeast-2")[:2] == "cn":
    request_url = "https://signin.amazonaws.cn/federation" + request_parameters
else:
    request_url = "https://signin.aws.amazon.com/federation" + request_parameters
r = requests.get(request_url)
# Returns a JSON document with a single element named SigninToken.
signin_token = json.loads(r.text)

# Step 5: Create URL where users can use the sign-in token to sign in to
# the console. This URL must be used within 15 minutes after the
# sign-in token was issued.
request_parameters = "?Action=login"
request_parameters += "&Issuer=Example.org"
if os.getenv("AWS_REGION", "ap-southeast-2")[:2] == "cn":
    request_parameters += "&Destination=" + quote_plus_function(
        "https://console.amazonaws.cn/"
    )
else:
    request_parameters += "&Destination=" + quote_plus_function(
        "https://console.aws.amazon.com/"
    )
request_parameters += "&SigninToken=" + signin_token["SigninToken"]
if os.getenv("AWS_REGION", "ap-southeast-2")[:2] == "cn":
    request_url = "https://signin.amazonaws.cn/federation" + request_parameters
else:
    request_url = "https://signin.aws.amazon.com/federation" + request_parameters

# Send final URL to stdout
print(request_url)
