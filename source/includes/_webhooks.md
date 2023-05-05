# Webhooks

Use incoming webhooks to get real-time updates.

ArcSite uses webhooks to notify your application when an event happens in your organization. Webhooks are particularly useful for asynchronous events like new drawing created.

A webhook enables ArcSite to push real-time notifications to your app. ArcSite uses HTTPS to send these notifications to your app as a JSON payload. You can then use these notifications to execute actions in your backend systems.

You can create and manage your webhooks from [the ArcSite web UI](https://user.arcsiteapp.com#/admin).

A of webhook payload contains both _event type_ and _payload data_.

> Sample webhook payload

```json
{
  "event": "project.created",
  "data": {
    "id": 36029621652695040,
    "name": "project 4",
    "created_at": "2022-01-16T04:19:23",
    "updated_at": "2022-01-16T04:19:23",
    "job_number": "144111",
    "customer": {
      "name": "Jack",
      "phone": "1441",
      "second_phone": "1122"
    }
  }
}
```

## Built-in retries

ArcSite webhooks have built-in retry methods for 3xx, 4xx, or 5xx response status codes. If ArcSite doesn’t quickly receive a 2xx response status code for an event, webhooks will retry the event until it receives a 2xx response or up to certain times.

## Project Created

`project.created` Triggerd when a project is created.

### Project Created Webhook Payload

| Parameter          | Type     | Description                                    |
| ------------------ | -------- | ---------------------------------------------- |
| id                 | String   | (required) ID of the project                   |
| name               | String   | (required) Name of the project                 |
| customer           | Customer | (optional) Customer profile of the project     |
| job_number         | String   | (optional) Job number of the project           |
| work_site_addreess | Address  | (optional) Worksite address of the project     |
| sales_rep          | SalesRep | (optional) Sales Representative of the project |

## Drawing Created

The `drawing.created` webhook will be triggered when a drawing is created by uploading PDF files on the user site or manually uploading some newly created drawing to the cloud from the ArcSite App.

<aside class="notice">
The returned <code>pdf_url</code> or <code>png_url</code> will expire in 24 hours. They are not permanent links and should not be used in your system directly. You need to download the files from the urls for your future use.

For drawing created from the user site by uploading PDF files, the <code>png_url</code> will be null.

</aside>

### Drawing Created Webhook Payload

| Parameter  | Type   | Description                                              |
| ---------- | ------ | -------------------------------------------------------- |
| id         | String | (required) ID of the drawing                             |
| project_id | String | (required) Project ID of the drawing                     |
| name       | String | (required) Name of the drawing                           |
| pdf_url    | String | (required) Download address of PDF format of the drawing |
| png_url    | String | Download address of PNG format of the drawing            |

## Drawing Updated

The drawing.updated webhook is triggered whenever a drawing is manually re-uploaded to the cloud from the ArcSite App after its initial creation.

<aside class="notice">
The returned <code>pdf_url</code> or <code>png_url</code> will expire in 24 hours. They are not permanent links and should not be used in your system directly. You need to download the files from the urls for your future use. 
</aside>

### Drawing Updated Webhook Payload

| Parameter  | Type   | Description                                              |
| ---------- | ------ | -------------------------------------------------------- |
| id         | String | (required) ID of the drawing                             |
| project_id | String | (required) Project ID of the drawing                     |
| name       | String | (required) Name of the drawing                           |
| pdf_url    | String | (required) Download address of PDF format of the drawing |
| png_url    | String | (required) Download address of PNG format of the drawing |

## Proposal PDF Signed

`proposal.signed` Triggerd when a proposal is signed.

<aside class="notice">
The returned <code>url</code> will expire in 24 hours. It's not a permanent link and should not be used in your system directly. You need to download the file from the url for your future use. 
</aside>

### Pwoposal PDF signed Webhook Payload

| Parameter  | Type   | Description                                   |
| ---------- | ------ | --------------------------------------------- |
| project_id | String | (required) Project ID of the drawing          |
| name       | String | (required) File name of the signed document   |
| url        | String | (required) Download address of the signed pdf |
