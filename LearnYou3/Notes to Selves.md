30 July 9pm+

Workflow:
✓1) They sign in with USERNAME and PASSWORD.
✓2) The app already has a CLIENT ID and CLIENT SECRET.
✓3) We get an OAuth token for the user via
POST /authorizations
(https://developer.github.com/v3/oauth_authorizations/#create-a-new-authorization)
++After signing in, we get a token. When does that expire?

3a) Keep in mind SCOPES (not the monkey trial! https://developer.github.com/v3/oauth/#scopes)
++Current scope "repo"


31 July AM

4) Refactor AFHTTPSessionManager to be a singleton.


Make method that returns pagination for a given request.
Make a method that returns any given page, and returns it.
Loop over that method.
Done.