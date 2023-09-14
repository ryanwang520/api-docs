# I360 Integrations

To better serve users who simultaneously use ArcSite and I360, ArcSite provides a standard integration solution for I360. After successfully integrating I360 through this solution, you can support the following extended functionalities:

* Bind `I360 Appointments` to ArcSite `Project`
* Automatically synchronize `Drawing PDFs data (including PDF files of Drawings and Proposal PDFs)` for bound Projects
* Proactively push `Product Lines` information to I360 Appointments for bound Projects from both the App and User Site
* Support subscription to the [I360 Project Sell](#i360-project-sell) webhook

Depending on the integration purpose, we can divide the integration into Basic Standard Integration and Extended Integration

## Basic Standard Integration

**Connecting I360 in ArcSite**

For specific settings and connection methods, please refer to the Setup document:
[I360 Integration Setup Part One - Customer Steps]**[I360 Integration Setup Part One - Customer Steps](https://support.improveit360.com/hc/en-us/articles/4406541659543-ArcSite-improveit-360-Integration-Setup-Part-One-Customer-Steps)**.

**Creating Project and binding Appointment to Project**

* Create an ArcSite Project using information from an I360 Appointment through the **[ArcSite Project Create API](#create-project)**.
* Bind an I360 Appointment to a specified ArcSite Project using [I360 Appointment Bind](#i360-appointment-bind).

<aside class='notice'>Completing the Basic Standard Integration provides you with essential ArcSite I360 integration functionality. It includes automatic synchronization of Drawing PDFs data, proactive pushing of Sales and Sales Item information to I360 Appointments, and changing the Appointment status to Sold. These functionalities are ready to use in ArcSite and do not require additional custom development.</aside>

### Validating the Integration

After successfully creating the project and binding the appointment, users can verify the integration in ArcSite. First, check if the corresponding ArcSite Project has been successfully created in the Projects list. If you can see the corresponding project, it indicates that the integration creation was successful. To further confirm the binding relationship, you can follow these steps:

1. Confirm whether the Project created through the API appears in the Project List. If it doesn't appear, it indicates a project creation failure. Please check the error message returned by the creation API and adjust the data before making another request.
   ![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/project_list_png.png)
2. In the ArcSite app, within the Project, create a Drawing and synchronize it to the Cloud.
3. On the ArcSite website, click on the uploaded Drawing.
4. In the Takeoff & Estimate Tab, check if the 'Send to I360' button appears.
   ![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/send_to_i360_png.png)
5. If the 'Send to I360' button appears, it confirms that the binding relationship is successful, and this Project can use the data synchronization function.

<aside class='notice'>
This completes the validation process for the integration. If you encounter any issues during the validation process, please review the steps and ensure that the Project was created successfully using APIs.
</aside>


### Data Synchronization Logic After Standard Integration

The data synchronization logic is divided into two parts based on the type of data:

### Drawing PDF Data and Proposal PDFs Data

**Synchronization of PDF data is automatic**

  * Synchronization Timing:

    ![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/upload_to_cloud_png.png)

    ![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/export_proposal_png.png)

    Whenever there is a change in the user's Drawing information and the changes are synchronized to the cloud, ArcSite automatically initiates a data synchronization task to push the new data to the corresponding I360 Appointment as needed.

  * Synchronization Logic:
  
    The decision to initiate a push to I360 is based on the configuration in the **`is_push_drawing`** and **`is_push_proposal`** fields in the payload when binding the project. When a push is required, a task is generated to create the latest Drawing PDF data and export all of the user's Proposal Templates using the latest Drawing data, generating corresponding Proposal PDFs. These files are then automatically pushed to I360 in an overwrite manner (each push will delete the previous attachments and create new ones).
  
  * Verification of Synchronization Results:
  
    Users can find these files in the Attachments of the Appointment corresponding to the Project in I360.

### Products Information within Drawings

   **The synchronization of Products data is manual

  * Synchronization Timing:**

    - In the ArcSite app, whenever an Export Customer Proposal is successful, after viewing the generated PDF, clicking on "Done" in the top left corner will prompt a pop-up asking "Did you sell this project?" If the user selects "Yes," ArcSite will initiate an asynchronous task to push the Products data to I360.
    ![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/did_you_sell_project_png.png)
    - On the User Site, users can click "Send to I360" in the Drawing's Takeoff & Estimate Tab to initiate the Products data push to I360.
    ![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/user_site_push_items.png)

  * Synchronization Logic:
    
    Based on the Product Line Items, Tax information, Price Adjustment information, and Custom Items used in the Drawing during the push, ArcSite assembles the mapping information for I360 Sales and Sales Items. Then, it pushes the **Sales and SalesItems** to I360 and sets the **`i360__Result__c`** of the Appointment as "**Sold**".
    
  * Verification of Results:
    
    Users can find these Sales and Sales Items in the Appointment corresponding to the Project in I360.

## Extended Integration

If you require additional extended functionalities, you can subscribe to and use the Webhooks and APIs prepared for I360 Integration. Through these Webhooks and APIs, users can develop more custom features to enhance support.

* Subscribe to the [I360 Project Sell](#i360-project-sell) Webhook for custom feature development.
* Use the [I360 Bound Product](#i360-bound-product) API to obtain information about the I360 Product IDs bound to ArcSite Products.


### Example of Custom Feature Development Using Extended Integration:

Suppose a user completes editing a Drawing in the App, syncs the Drawing to the Cloud, and wishes to generate a corresponding Quote and Quote Items in I360 when exporting a Proposal and selecting "No" when selling the Project. Additionally, they want to customize the management of the Appointment's status.

Implementation Steps:

1. Ensure that the Basic Standard Integration is completed, then subscribe to the [I360 Project Sell](#i360-project-sell) Webhook on the User Site.
2. When a user selects "No" in the App, ArcSite pushes relevant Payload information to the registered Webhook URL.
3. Extract the Drawing ID and Appointment ID from the Payload.
4. Use the extracted Drawing ID to obtain all Line Item information from the Drawing through the [Drawing Line Items API](#get-line-items).
5. Map and assemble the I360 `Quote` data.

    **Mapping I360 Quote Data**
    1. Use the Drawing Name as the Quote Name.
    2. Use the total from Drawing Line Items as the total for the Quote.
    3. Use tax / total from Drawing Line Items as the `i360__Quote_Tax_Rate__c` information for the Quote.
    4. Use the extracted Appointment ID from the Webhook payload as the `i360__Appointment__c` information for the Quote.

6. Map and assemble the I360 `QuoteItem` data.

    **Mapping I360 QuoteItems Data**
    1. Use the Line Item's name as the QuoteItem's name.
    2. Use the Line Item's description as the QuoteItem's description.
    3. Use the Line Item's quantity as the QuoteItem's quantity.
    4. Use total / quantity from the Line Item as the unit_price for the `QuoteItem`.
    5. Retrieve the I360 Product ID information based on the Line Item's product id through the [I360 Bound Product](#i360-bound-product).
    6. Use the obtained I360 Product ID as the `i360__Product__c` for the `QuoteItem`
    7. Other information can be mapped as needed. 

7. Customize the modification of Appointment status and any other subsequent functional changes as required.


## I360 Appointment Bind

```shell
curl -X POST 'https://api.arcsite.com/v1/integrations/i360/bind_project/' \
-H 'Authorization: Bearer **your_api_token_here**' \
-H 'Content-Type: application/json' \
-d '{
  "appointment_id": "AXh09668400GJgk",
  "project_id": "36029621653386360",
  "is_push_drawing": true,
  "is_push_proposals": true,
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

This endpoint binds a i360 appointment to an exist ArcSite project.

### HTTP Request

`POST https://api.arcsite.com/v1/integrations/i360/bind_project/`

### Parameters

| Parameter          | Type | Description                                     |
|--------------------|-----|-------------------------------------------------|
| appointment_id     | String | (required) The ID of the appointment id in I360 |
| project_id         | Int | (required) The exist arcsite project id         |
| is_push_drawing           | Boolean | (optional) 是否自动推送Drawing PDF Data到Appiontment   |
| is_push_proposals         | Boolean | (optional) 是否自动推送Proposal PDFs到Appiontment      |

<aside class='notice'>
<code>project_id</code> An ArcSite Project can only be bound to one Appointment, and attempting to bind it again if it's already bound will result in a failure.
</aside>


## I360 Bound Product

```shell
curl 'https://api.arcsite.com/v1/integrations/i360/product/<product_id>/mapped_data/' \
-H 'Authorization: Bearer **your_api_token_here**' 
```

> The above command returns JSON structured like this:

```json
{
  "mapping_product_id": "AXh09668400GJgk",
}
```

This endpoint will return the bound i360 product id.

### HTTP Request

`POST https://api.arcsite.com/v1/integrations/i360/product/<product_id>/mapped_data/`

<aside class='notice'>
<code>mapping_product_id</code> If product has not been bound to an I360 Product in ArcSite, it will return <strong>null</strong>.
</aside>

## I360 Project Sell

`integration.i360.project_sell` Triggered when a project is sold by user in app.

<aside class="warning">
<span style="color: #FFF">Currently, users can only subscribe to this webhook after successfully connecting to the I360 environment. This webhook is designed to handle cases where users select "No".
if a user selects "Yes," the webhook will not be triggered.
</span></aside>

### I360 Project Sell Webhook Payload

| Parameter          | Type     | Description                                       |
|--------------------|----------|---------------------------------------------------|
| project_id         | String   | (required) The project id of selling project      |
| drawing_id         | String   | (required) The drawing of selling project         |
| appointment_id     | String   | (required) Bound Appointment ID                   |
| is_sold            | Boolean  | (required) Is user choose sold the project in App |


