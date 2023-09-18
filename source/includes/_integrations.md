# Integrations

## I360 Integration

ArcSite offers a comprehensive integration solution for I360, designed to enhance the experience of users who rely on both ArcSite and I360. This integration provides a range of extended functionalities, empowering your projects to:

- Associate `I360 Appointments` with ArcSite `Projects`
- Automatically synchronize `Drawing PDF data (including PDF files of Drawings and Proposal PDFs)` for associated Projects
- Proactively transmit `Product Lines` information to I360 Appointments for associated Projects, accessible via both the App and User Site
- Enable subscription to the [Proposal Exported in App associated with i360](#proposal-exported-in-app-associated-with-i360) webhook

Depending on your integration goals, we offer two levels of integration: the `Basic Standard Integration` and the `Extended Integration`.

In most cases, the **Basic Standard Integration** provides ample access to pre-built data interaction features offered by ArcSite, meeting the requirements of the majority of users. However, for those seeking more tailored development options, we offer the **Extended Integration**. This solution offers flexible APIs and Webhooks, enabling users to implement custom features as needed.

### Basic Standard Integration

**Integrating I360 into ArcSite**

For detailed settings and connection methods, please consult our setup guide:
**[I360 Integration Setup Part One - Customer Steps](https://support.improveit360.com/hc/en-us/articles/4406541659543-ArcSite-improveit-360-Integration-Setup-Part-One-Customer-Steps)**.

**Associating I360 Appointments with ArcSite Projects**

- Use the **[ArcSite Project Create API](#create-project)** to generate an ArcSite Project using information from an I360 Appointment.
- Associate an I360 Appointment with a specific ArcSite Project through [Associate I360 Appointment with ArcSite Project](#associate-i360-appointment-with-arcsite-project).

<aside class='notice'>Completing the Basic Standard Integration provides you with essential ArcSite I360 integration functionality, including automatic synchronization of Drawing PDF data, proactive transmission of Sales and Sales Item information to I360 Appointments, and updating the Appointment status to "Sold." These features are readily available in ArcSite and do not require additional custom development.</aside>

### Validating the Integration

Once you've successfully created the project and associated with the appointment, you can verify the integration status in ArcSite. Start by confirming if the corresponding ArcSite Project has been successfully created in the Projects list. If you can locate the corresponding project, it indicates a successful integration creation. To further confirm the association, follow these steps:

1. Check if the Project created via the API appears in the Project List. If it's missing, this indicates a project creation failure. Review the error message from the creation API and adjust the data before making another request.
   ![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/project_list_png.png)
2. Within the ArcSite app, create a Drawing within the Project and upload it to the Cloud.
3. On the ArcSite website, select the uploaded Drawing.
4. In the Takeoff & Estimate Tab, ensure the 'Send to I360' button is visible.
   ![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/send_to_i360_png.png)
5. If the 'Send to I360' button appears, it confirms the successful association, allowing the Project to utilize data synchronization.

<aside class='notice'>
This concludes the validation process for the integration. If you encounter any issues during validation, please review the steps and ensure that the Project was created successfully using the <a href="#create-project">Create Project</a> API.
</aside>

### Connecting Products between ArcSite and I360

ArcSite supports the connection of one I360 product to an ArcSite product through the web page. Once connected, product information synchronizes with the I360 appointment when pushing drawing line item information to I360.

To connect products, follow these steps:

1. Verify that the I360 environment is correctly set up, and the product exists in both I360 and ArcSite.
   ![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/connected_i360_env_to_arcsite.png)
2. Navigate to `Integrations` -> `Product Manager` to locate the product you wish to connect.
   ![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/click_connect_to_product_2.png)
3. Click the connect button and select the corresponding I360 product.
   ![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/select_i360_product_to_connect.png)
4. After connecting, the product status changes to connected, and the Connect button becomes Update.
   ![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/connected_i360_product.png)
5. If you wish to disconnect products, you can click Update, followed by the Disconnect button.
   ![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/disconnect_i360_product.png)

<aside class='notice'>Please note that this feature exclusively supports basic products; Product Bundles or Product Groups cannot connect to third-party products. Additionally, a single I360 product can only connect to one product.</aside>

### Data Synchronization Logic After Standard Integration

The data synchronization logic is divided into two categories, depending on the data type:

### Drawing PDF Data and Proposal PDFs Data

**Automatic PDF Data Synchronization**

- **Synchronization Timing**:
  ![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/upload_to_cloud_png.png)
  ![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/export_proposal_png.png)
  Whenever user Drawing information changes and these alterations sync to the cloud, ArcSite initiates an automatic data synchronization task to update the relevant I360 Appointment as necessary.

- **Synchronization Logic**:
  The decision to initiate a push to I360 is based on the configuration in the **`is_push_drawing`** and **`is_push_proposal`** fields when associating the project. When a push request is made, a task generates the latest Drawing PDF data and exports all PDFs of the user's Proposal Templates using the latest Drawing data. These files are then automatically pushed to I360, overwriting any existing attachments.

- **Verification of Synchronization Results**:
  Users can locate these files in the Attachments section of the Appointment associated with the Project in I360.

### Drawing Line Items and Pricing Information

The synchronization of Product data is manual.

- **Synchronization Timing**:
  - Within the ArcSite app, after a successful Export Customer Proposal, viewing the generated PDF and selecting "Done" in the top left corner triggers a pop-up asking "Did you sell this project?" If the user answers "Yes," ArcSite initiates an asynchronous task to push the Drawing Line Item data to I360.
    ![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/did_you_sell_project_png.png)
  - On the User Site, users can click "Send to I360" in the Drawing's Takeoff & Estimate Tab to initiate the Product data push to I360.
    ![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/user_site_push_items.png)

- **Synchronization Logic**:
  ArcSite assembles mapping information for I360 Sales and Sales Items based on Product Line Items, Tax information, Price Adjustment information, and Custom Items used in the Drawing during the push. It then pushes the **Sales and Sales Items** to I360 and sets the **`i360__Result__c`** of the Appointment as "**Sold**."

- **Verification of Results**:
  Users can find these Sales and Sales Items in the Appointment corresponding to the Project in I360.

### Extended Integration

For those requiring advanced features, ArcSite provides Webhooks and APIs tailored for I360 Integration. These tools enable users to develop custom functionalities to enhance their support.

- Subscribe to the [Proposal Exported in App associated with i360](#proposal-exported-in-app-associated-with-i360) Webhook for custom feature development.
- Utilize the [Connected I360 Product](#connected-i360-product) API to access information about I360 Product IDs connected to ArcSite Products.

### Example of Custom Feature Development Using Extended Integration:

Imagine a scenario where a user, after editing a Drawing in the App, syncs it to the Cloud, and wishes to generate a corresponding Quote and Quote Items in I360 when exporting a Proposal, selecting "No" when selling the Project. Additionally, they want to customize the management of the Appointment's status.

Implementation Steps:

1. Ensure the Basic Standard Integration is complete, then subscribe to the [Proposal Exported in App associated with i360](#proposal-exported-in-app-associated-with-i360) Webhook on the User Site.
2. When a user selects "No" in the App, ArcSite pushes relevant Payload information to the registered Webhook URL.
3. Extract the Drawing ID and Appointment ID from the Payload.
4. Use the Drawing ID to obtain all Line Item information from the Drawing through the [Drawing Line Items API](#get-line-items).
5. Map and assemble I360 `Quote` data.

    **Mapping I360 Quote Data**
    1. Utilize the Drawing Name as the Quote Name.
    2. Use the total from Drawing Line Items as the Quote's total.
    3. Apply tax / total from Drawing Line Items as the `i360__Sales_Tax_Rate__c` for the Quote.
    4. Utilize the extracted Appointment ID from the Webhook payload as the `i360__Appointment__c` for the Quote.

6. Map and assemble the I360 `QuoteItem` data.

    **Mapping I360 Quote Item Data**
    1. Use the Line Item's name as the QuoteItem's name.
    2. Employ the Line Item's description as the QuoteItem's description.
    3. Implement the Line Item's quantity as the QuoteItem's quantity.
    4. Set the unit_price for the `Quote Item` using total / quantity from the Line Item.
    5. Retrieve the I360 Product ID information based on the Line Item's product id through the [Connected I360 Product](#connected-i360-product).
    6. Use the obtained I360 Product ID as the `i360__Product__c` for the `Quote Item`.
    7. Customize other information as needed. 

7. Customize the modification of Appointment status and any subsequent functional changes as required.


### Associate I360 Appointment with ArcSite Project

```shell
curl -X POST 'https://api.arcsite.com/v1/i360/associate_project/' \
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

This endpoint establishes an association between an I360 appointment and an existing ArcSite project.

### HTTP Request

`POST https://api.arcsite.com/v1/i360/associate_project/`

### Parameters

| Parameter          | Type | Description                                                                                     |
|--------------------|-----|-------------------------------------------------------------------------------------------------|
| appointment_id     | String | (required) The ID of the appointment in I360.                                              |
| project_id         | Int | (required) The ID of the existing ArcSite project.                                                        |
| is_push_drawing           | Boolean | (optional) Specifies whether to automatically send Drawing PDF files to the I360 Appointment. Default is true. |
| is_push_proposals         | Boolean | (optional) Specifies whether to automatically send Proposal PDF files to the I360 Appointment. Default is true.         |

<aside class='notice'>
<code>project_id</code> An ArcSite Project can only be associated with one Appointment, and attempting to associate it again if it's already associated will result in a failure.
</aside>

### APIs for I360

### Connected I360 Product

In ArcSite, after setting up the I360 environment, you can connect an I360 Product to an ArcSite Product within the ArcSite website.

To retrieve the connected I360 Product ID using an ArcSite Product ID, you can utilize this API:

```shell
curl 'https://api.arcsite.com/v1/i360/connected_product/<arcsite_product_id>/' \
-H 'Authorization: Bearer **your_api_token_here**' 
```

> The above command returns JSON structured like this:

```json
{
  "mapping_product_id": "AXh09668400GJgk",
}
```

This endpoint provides the connected I360 product ID.

### HTTP Request

`POST https://api.arcsite.com/v1/i360/connected_product/<arcsite_product_id>/`

<aside class='notice'>
<code>connected_product_id</code> If a product has not been connected to an I360 Product in ArcSite, it will return <strong>null</strong>
</aside>

### Webhooks for I360

### Proposal Exported in App associated with i360

The `proposal.exported.app.i360` webhook is triggered when a project associated with an I360 appointment is exported in the ArcSite app, and the user does not mark the project as sold within the app.

This webhook is specifically triggered under the following conditions:

* The project is associated with an I360 appointment.
* Subscription to this webhook is active on the ArcSite user site.
![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/sub_webhook_page.png)
* The project is exported in the ArcSite app, and it is associated with an I360 appointment.
![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/export_proposal_png.png)
* The user does not mark the project as sold in the app when prompted.
![Untitled](https://cdn-public.arcsiteapp.com/api_docs_images/mark_select_no_in_app.png)


<aside class="warning">
<span style="color: #FFF">
This webhook is triggered when the user selects "No" in the app. If the user selects "Yes," the webhook will not be triggered, and ArcSite will automatically push the drawing line items data to I360 using the default logic.
</span></aside>

### Proposal Exported in App associated with i360 Webhook Payload

| Parameter          | Type     | Description                                                                    |
|--------------------|----------|--------------------------------------------------------------------------------|
| project_id         | String   | (required) The project id of the project                                       |
| drawing_id         | String   | (required) The drawing of the project                                          |
| appointment_id     | String   | (required) Associated Appointment ID                                           |
| is_sold            | Boolean  | (required) Indicates if the user chose to mark the project as sold in the app. |


