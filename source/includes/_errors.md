# Errors

ArcSite uses HTTP response codes to indicate the success or failure of a request. Codes within the 2xx range are considered as successfully completed transactions. Codes within the 4xx and 5xx ranges will indicate that a failure has occurred.

We use the following error codes to manage common failures.

The ArcSite API uses the following error codes:

| Error Code         | Meaning                                                                                             |
| ------------------ | --------------------------------------------------------------------------------------------------- |
| 400                | Bad Request -- Your request is invalid.                                                             |
| 401                | Unauthorized -- Your API key is wrong.                                                              |
| 404                | Not Found -- The specified kitten could not be found.                                               |
| 405                | Method Not Allowed -- You tried to access a kitten with an invalid method.                          |
| 406                | Not Acceptable -- You requested a format that isn't json.                                           |
| 500, 502, 503, 504 | There is an issue with Responsive Invoices. These are rare and we will be messaged when they occur. |
|                    |
