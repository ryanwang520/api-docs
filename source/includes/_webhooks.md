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

`project.created` Triggered when a project is created.

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

The `drawing.updated` webhook is triggered whenever a drawing is manually re-uploaded to the cloud from the ArcSite App after its initial creation.

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

### Proposal PDF signed Webhook Payload

| Parameter          | Type   | Description                                                    |
|--------------------| ------ |----------------------------------------------------------------|
| project_id         | String | (required) Project ID of the drawing                           |
| name               | String | (required) File name of the signed document                    |
| url                | String | (required) Download address of the signed pdf                  |
| drawing_id         | String | (required) The associated drawing id of the signed pdf         |
| drawing_version_id | String | (required) The associated drawing version id of the signed pdf |


## Proposal Sent

`proposal.sent` Triggerd when a proposal is sent to customer.

<aside class="notice">
A proposal option is associated with a specific drawing version in Arcsite. If you need to get the line items data of the specified drawing version, you can use the <code>drawing_version_id</code> of the option in the Get line items API.
</aside>

### Proposal Sent Webhook Payload

| Parameter            | Type                 | Description                                  |
|----------------------|----------------------|----------------------------------------------|
| proposal_id          | id                   | (required) Proposal ID                       |
| name                 | String               | (required) Proposal name                     |
| customer_name        | String               | (required) Proposal customer name            |
| receive_email        | String               | (required) Proposal receiver email           |
| contact_email        | String               | (required) The sales email                   |
| sales_representative | String               | (required) The sales name                    |
| receive_cc           | List[String]         | (required) The proposal receive cc email list |
| proposal_options     | List[ProposalOption] | (required) The proposal option data list     |

### ProposalOption

| Parameter            | Type                 | Description                                                  |
|----------------------|----------------------|--------------------------------------------------------------|
| name                 | String               | (required) Proposal option name                              |
| drawing_id           | String               | (required) The proposal option associated drawing ID         |
| drawing_version_id   | String               | (required) The proposal option associated drawing version ID |
| total                | String               | (required) The total of the proposal option                  |


## Proposal Approved

`proposal.approved` Triggerd when a proposal is approved by customer.


### Proposal Sent Webhook Payload

| Parameter                 | Type                 | Description                                     |
|---------------------------|----------------------|-------------------------------------------------|
| proposal_id               | id                   | (required) Approved proposal ID                 |
| project_id                | id                   | (required) Approved proposal related project ID |
| name                      | String               | (required) Approved proposal name               |
| approved_option           | ProposalOption       | (required) Approved proposal option data        |
