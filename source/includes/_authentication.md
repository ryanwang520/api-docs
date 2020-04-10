
# Authentication
> To authorize, use this code:

```shell
# With shell, you can just pass the correct header with each request
curl "https://www.happyscribe.co/api/v1/" \
  -H "Authorization: Bearer **your_api_key_here**"
```

```javascript
fetch('https://www.happyscribe.co/api/v1/', {
  headers: {
    authorization: 'Bearer **your_api_key_here**'
  }
})
```

> Make sure to replace `**your_api_key_here**` with your API key.

Happy Scribe uses API keys to allow access to the API. You can get your API key by logging in and going to [settings](https://www.happyscribe.co/users/edit) 

Happy Scribe expects the API key to be included in all API requests to the server in a header that looks like the following:

`Authorization: Bearer **your_api_key_here**"`

<aside class="notice">
You must replace <code>**your_api_key_here**</code> with your personal API key.
</aside>