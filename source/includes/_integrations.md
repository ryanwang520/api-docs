# Integrations

## Improveit360 Integration

ArcSite Provides Out-of-the-Box [Basic Standard Integration](#basic-standard-integration) for essential features. With Basic Standard Integration, it supports auto-pushing Drawing PDFs, updating Sales data in I360 Appointments, and setting Appointment statuses to "<strong>Sold</strong>". No extra custom development is needed.

For more tailored solutions, go with [Extended Integration](#advanced-features-with-extended-integration) that comes with flexible APIs and Webhooks.

### Basic Standard Integration

**Integrating I360 into ArcSite**

For detailed settings and connection methods, please consult the setup guide:
**[I360 Integration Setup Part One - Customer Steps](https://support.improveit360.com/hc/en-us/articles/4406541659543-ArcSite-improveit-360-Integration-Setup-Part-One-Customer-Steps)**.

**Associating I360 Appointments with ArcSite Projects**

- Use the **[ArcSite Project Create API](#create-project)** to generate an ArcSite Project using information from an I360 Appointment.
- Associate an I360 Appointment with a specific ArcSite Project through [Associate I360 Appointment with ArcSite Project](#associate-i360-appointment-with-arcsite-project).

<aside class='notice'>We recommend using the two APIs above for basic integration. The old Create Project API (POST https://user.arcsiteapp.com/extapi/projects/create/) will no longer be supported.
</aside>

### Validating the Integration

Once you've successfully created the project and associated with the appointment, you can verify the integration status in ArcSite follow these steps:

1. Check if the Project created via the API appears in the Project List. If it's missing, this indicates a project creation failure.
   ![Untitled](images/i360/project_list_png.png)
2. Within the ArcSite app, create a Drawing within the Project and upload it to the Cloud.
3. On the ArcSite user site, select the uploaded Drawing.
4. In the Takeoff & Estimate Tab, ensure the **Send to I360** button is visible.
   ![Untitled](images/i360/send_to_i360_png.png)
5. If the **Send to I360** button appears, it confirms the successful association, allowing the Project to push data to associated i360 appointment. If the button is missing, this indicates a project association failure. Please check the [associate API](#associate-i360-appointment-with-arcsite-project) for more information.

### Connecting Products between ArcSite and I360

ArcSite supports the connection of one I360 product to an ArcSite product through the [ArcSite Product Manager](https://user.arcsiteapp.com/admin/product_integration) web page in user site. Once connected, this connection relationship will be used when ArcSite pushes Line Items data to I360.

To connect products, follow these steps:

1. Verify that the I360 environment is correctly set up, and the product exists in both I360 and ArcSite.
   ![Untitled](images/i360/connected_i360_env_to_arcsite.png)
2. Navigate to `Integrations` -> `Product Manager` to locate the product you wish to connect.
   ![Untitled](images/i360/click_connect_to_product_2.png)
3. Click the connect button and select the corresponding I360 product.
   ![Untitled](images/i360/select_i360_product_to_connect.png)
4. After connecting, the product status changes to connected, and the Connect button becomes Update.
   ![Untitled](images/i360/connected_i360_product.png)
5. If you wish to disconnect products, you can click Update, followed by the Disconnect button.
   ![Untitled](images/i360/disconnect_i360_product.png)

<aside class='notice'>Please note that this feature exclusively supports basic products, Product Bundles or Product Groups cannot connect to third-party products. Additionally, a single I360 product can only connect to one product.</aside>

### Data Pushing Details

We categorize data pushing into two types based on the data involved:

### Automatic Push for Drawing PDF and Proposal PDFs

- **When to Push**:
  ![Untitled](images/i360/upload_to_cloud_png.png)
  ![Untitled](images/i360/export_proposal_png.png)
  When user clicks the "Upload to Cloud" button or exports the custom proposal in the app, we will trigger out push to I360.

- **How It Works**:
  The latest Drawing PDFs and Proposal PDFs are generated and automatically pushing to I360, replacing any existing files.

- **How to Verify**:
  Check these files in the Attachments section of the associated I360 Appointment.

### Manual Push for Line Items and Pricing

- **When to push**:
  Product line items and pricing will be triggered:
  - When user clicks the `Export` button in the app, a `Did you sell this project?` pop-up appears, if you select "Yes" it will trigger the push.
    ![Did You Sell?](images/i360/did_you_sell_project_png.png)
  - Alternatively, click `Send to I360` button in the Takeoff & Estimate Tab on the drawing detail page of the user site.
    ![Send to I360](images/i360/user_site_push_items.png)

- **How It Works**:
  ArcSite pushes the corresponding drawing line items data to Sales and Sales Items of the I360 appointment, and updates the status of appointment to **`Sold`** then.

- **How to Verify**:
  Check the Sales and Sales Items in the corresponding I360 Appointment.

### Customized Features with Extended Integration

If you need more customized features, ArcSite's Extended Integration offers specialized Webhooks and APIs for I360.

- Subscribe to [Proposal Exported in App](#proposal-exported-in-app) for custom developments.
- Use the [Connected I360 Product](#connected-i360-product) API to fetch the connected I360 Product ID from ArcSite Product ID.

### Customized Feature Example:

Let's say you've edited a Drawing and want to auto-generate I360 Quote and Quote Items when you select "No" in "Did you sell this project" pop-up. You also want to change the I360 Appointment statuses then.

**Implementation Steps:**

```
 payload = get_payload_from_webhook()
 if payload.is_sold is False
     # extract drawing_id and appointment_id from payload
     drawing_id = payload.drawing_id
     appointment_id = payload.appointment_id
     # Fetch all Line Items info using drawing_id
     line_items = request_arcsite_drawing_line_items_api(drawing_id)
     # Generate I360 Quotes
     # Create I360 Quote Items
     # Optionally, modify the I360 Appointment status or add other custom features.
 else
     # Do nothing, arcsite will push line items data.
 ```

1. Complete Basic Integration and subscribe to the [Proposal Exported in App](#proposal-exported-in-app) Webhook.
2. ArcSite sends payload data to your webhook URL. You should to extract the `is_sold` from the payload and **handle the logic like the sample code** right side.
3. Extract `Drawing ID` and `Appointment ID` from the payload.
4. Fetch all Line items info using the `Drawing ID` via [Drawing Line Items API](#get-line-items).
5. **Generate an I360 Quote Object**
  - Name: Use the Drawing Name as the Quote's Name. 
  - Total: Use the `total` from the returned data as the `i360__Calculated_Total__c` of Quote. 
  - Tax Rate: Use sum of `tax` / `total` from returned data as the `i360__Sales_Tax_Rate__c` of Quote. 
  - Appointment ID: `appointment_id` extracted from the Webhook Payload.
6. **Create I360 Quote Items**
  - Name: Line item's `name`
  - Quantity: Line item's `quantity`
  - Unit Price: Use line item's `total` / `quantity` as the `i360__Unit_Price__c` of QuoteItem.
  - Product ID: Fetch connected i360 product id using the Line Item's `product_id` via [Connected I360 Product](#connected-i360-product).
7. Optionally, modify the I360 Appointment status or add other custom features.


### APIs for I360


### Associate I360 Appointment with ArcSite Project

```shell
curl -X POST 'https://api.arcsite.com/v1/i360/associate_project' \
-H 'Authorization: Bearer **your_api_token_here**' \
-H 'Content-Type: application/json' \
-d '{
  "appointment_id": "AXh09668400GJgk",
  "project_id": "36029621653386360"
}'
```

> The above command returns JSON structured like this:

```json
{
  "id": "36029621653386360",
  "name": "nac",
  "created_at": "2022-01-16T03:31:39",
  "updated_at": "2022-01-16T03:31:39",
  "job_number": "heeloo",
  "customer": {
    "name": "hello",
    "phone": "122112",
    "second_phone": "122112",
    "email": "dev@arctuition.com",
    "second_email": "dev@arctuition.com",
    "address": {
      "street": "address",
      "city": "city",
      "county": "county",
      "state": "state",
      "zip_code": "200544"
    }
  },
  "work_site_address": {
    "street": "street",
    "city": "city",
    "county": "county",
    "state": "state",
    "zip_code": "300433"
  },
  "sales_rep": {
    "name": "Wang",
    "email": "dev@arctuition.com",
    "phone": "122112"
  }
}
```

This endpoint establishes an association between an I360 appointment and an existing ArcSite project.

### HTTP Request

`POST https://api.arcsite.com/v1/i360/associate_project`

### Parameters

| Parameter      | Type   | Description                                        |
| -------------- | ------ | -------------------------------------------------- |
| appointment_id | String | (required) The ID of the appointment in I360.      |
| project_id     | Int    | (required) The ID of the existing ArcSite project. |

<aside class='notice'>
An ArcSite Project can only be associated with one Appointment, and attempting to associate it again if it's already associated will result in a failure.
</aside>

### Connected I360 Product

In ArcSite, after setting up the I360 environment, you can connect an I360 Product to an ArcSite Product within the ArcSite website.

To retrieve the connected I360 Product ID using an ArcSite Product ID, you can utilize this API:

```shell
curl 'https://api.arcsite.com/v1/i360/connected_product/<arcsite_product_id>' \
-H 'Authorization: Bearer **your_api_token_here**'
```

> The above command returns JSON structured like this:

```json
{
  "mapping_product_id": "AXh09668400GJgk"
}
```

This endpoint provides the connected I360 product ID.

### HTTP Request

`POST https://api.arcsite.com/v1/i360/connected_product/<arcsite_product_id>`

<aside class='notice'>
If a product has not been connected to an I360 Product in ArcSite, it will return a 400 error.
</aside>

### Webhooks for I360

### Prompt after exporting proposal in App

This webhook is triggered after a proposal under the project associated with the i360 appointment is exported in the ArcSite application and the user clicks Yes or No when prompted.

This webhook is specifically triggered under the following conditions:

- The project is associated with an I360 appointment.
- Subscription to this webhook is active on the ArcSite user site.
  ![Untitled](images/i360/sub_webhook_page.png)
- The project is exported in the ArcSite app, and it is associated with an I360 appointment.
  ![Untitled](images/i360/export_proposal_png.png)
- The user choose the "Yes" or "No" in the app when prompted.
  ![Untitled](images/i360/did_you_sell_project_png.png)

### Prompt after exporting proposal in App Webhook Payload

| Parameter      | Type    | Description                              |
|----------------| ------- |------------------------------------------|
| project_id     | String  | (required) The project id of the project |
| drawing_id     | String  | (required) The drawing of the project    |
| appointment_id | String  | (required) Associated Appointment ID     |
| yes_no         | Boolean | (required) User Selection                |
