---
title: Errors
description: HTTP response codes the ArcSite API returns to indicate request success or failure.
---

ArcSite uses HTTP response codes to indicate the success or failure of a request. Codes within the 2xx range are considered as successfully completed requests. Codes within the 4xx and 5xx ranges will indicate that a failure has occurred.

## Error response body

Most errors return a JSON object with a human-readable `message`:

```json
{
  "message": "Not found"
}
```

Treat `message` as text for logs and people, not as a stable identifier: branch on the HTTP status code. A `401` response usually has an empty body (`{}`), a request to a URL that doesn't exist (including a trailing `/` on an endpoint path) returns a `404` with an HTML body, and an unexpected server error returns a `500` whose body has a different shape.

## Status codes

| Error Code         | Meaning                                                                                                                                       |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------------------------- |
| 400                | Bad Request -- Your request is invalid: a required field is missing, a value has the wrong type, or the request body isn't valid JSON.        |
| 401                | Unauthorized -- The `Authorization` header is missing or malformed, or the API token is wrong or has been deleted.                            |
| 403                | Forbidden -- The resource exists but belongs to an organization your API token can't access.                                                  |
| 404                | Not Found -- The specified resource could not be found.                                                                                       |
| 405                | Method Not Allowed -- You tried to access an API with an invalid method.                                                                      |
| 406                | Not Acceptable -- The request has a body whose `Content-Type` isn't `application/json` (or `multipart/form-data` for file uploads).           |
| 429                | Too Many Requests -- You have sent too many requests in a given amount of time. See [Rate limits](#rate-limits).                              |
| 500, 502, 503, 504 | There is an issue with ArcSite. These are rare and we will be messaged when they occur.                                                       |

## Rate limits

Requests are rate limited per organization: all API tokens of an organization share one limit of 5,000 requests per hour. The window is fixed and resets at the start of each hour (UTC). Requests over the limit receive a `429` response:

```json
{
  "message": "Too many requests. Please wait before trying again."
}
```

The response has no `Retry-After` header. Wait until the next hour starts, or back off and retry.
