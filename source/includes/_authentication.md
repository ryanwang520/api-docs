# Authentication

> To authorize, use this code:

```shell
# With shell, you can just pass the correct header with each request
curl "https://api.arcsiteapp.com/v1/projects" \
  -H "Authorization: Bearer your_api_token"
```

> Make sure to replace `your_api_token` with your API token.

The ArcSite API uses API tokens to authenticate requests. You can view and manage your API tokens by visiting the [ArcSite Dashboard](https://user.arcsiteapp.com/).

Authentication to the API is performed via [HTTP Authorization Header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Authorization).

All API requests must be made over [HTTPS](https://en.wikipedia.org/wiki/HTTP_Secure). Calls made over plain HTTP will fail. API requests without authenciation will also fail.

`Authorization: Bearer **your_api_token_here**`

<aside class="notice">
You must replace <code>your_api_token_here</code> with your personal API token.
</aside>
