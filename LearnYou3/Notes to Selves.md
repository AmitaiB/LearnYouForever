30 July 9pm+

Workflow:
1) They sign in with USERNAME and PASSWORD.
2) The app already has a CLIENT ID and CLIENT SECRET.
3) We get an OAuth token for the user via
POST /authorizations
(https://developer.github.com/v3/oauth_authorizations/#create-a-new-authorization)
3a) Keep in mind SCOPES (not the monkey trial! https://developer.github.com/v3/oauth/#scopes)
