# Campaign Influence Starter Pack

This Starter Pack was developed for professionals who have already set up Connected Campaigns and Campaign Influence, and now want to understand what kind of reporting is available to them. If you need help with the setup, someone to bounce questions off of, or just a second set of eyes, you’re in luck: Sercante has helped many companies through Connected Campaigns & Campaign Influence Reporting. [Let's Chat >](https://www.sercante.com/contact-us/)

> This sample application is designed to run on Salesforce Platform. 

> This package is designed to both run independently (in a self contained scratch org) as well as be directly deployed to an existing org (Sandbox or Production).

> Users who wish to view the Dashboards and Reports will need to have the **Campaign Influence** Permission.

## What You Get
When deploying to your org, this package simply installs:
- 1 Report Folder
- 14 Reports
- 1 Dashboard Folder
- 2 Dashboards (one for Lightning, one for Classic)

## Table of contents

- [Installing the Starter Pack Using an Org](#installing-the-starter-pack-using-an-org): This is the recommended option to begin building and deploying your own reports and dashboards.

- [Installing the Starter Pack Using a Scratch Org](#installing-the-starter-pack-using-a-scratch-org): This is the recommended option to explore the reports and dashboards.

- [Note on Sample Data Import](#note-on-sample-data-import)

- [Optional installation instructions](#optional-installation-instructions)

## Installing the Starter Pack Using an Org

Follow this set of instructions if you want to deploy the app to a more permanent environment than a Scratch org.

Most of these instructions are Command Line, so you will need to launch and run either Terminal, Command Prompt or some similar program.

1. Make sure Customizable Campaign Influence has been enabled in your org.
    - [Campaign Influence - Spring '20 Documentation](https://resources.docs.salesforce.com/latest/latest/en-us/sfdc/pdf/campaign_influence_implementation_guide.pdf)
    - Must have:
        - Pardot Connected
        - Enabled **Connected Campaigns**
        - Enabled **Customizable Campaign Influence** and not **Campaign Influence 1.0**
        - Enabled all additional Campaign Models

1. Make sure the user you are deploying with has all the right permissions
    - **Campaign Influence** - This was setup in a permission set when Customizable Campaign Influence was set up
    - **Change Dashboard Colors** - This permission is needed in Lightning to deploy dasbhoards
    - **Create and Customize Dashboards**
    - **Create Dashboard Folders**
    - **Create and Customize Reports**
    - **Create Report Folders**

1. If you know about and use `git`, clone this repository

    ```
    git clone https://github.com/sercante-llc/campaign-influence-starter-pack
    cd campaign-influence-starter-pack
    ```

    **or**

    1. [Download a zip file](https://github.com/sercante-llc/campaign-influence-starter-pack/archive/master.zip)
    1. Extract the contents
    1. Navigate to the directory (sample commands below, though it may be different for you depending where you download things)

    ```
    cd Downloads/campaign-influence-starter-pack-master
    ```
    4. Verify you are in the same directory as the sfdx-project.json file
    ```
    # mac or Linux
    ls 

    # windows
    dir
    ```

1. Setup your environment
    - [Install Salesforce CLI](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_install_cli.htm)

1. Authorize your Salesforce org and provide it with a nickname (**myorgNickname** in the commands below)
    ```
    # Production: likely the command that will work for you
    sfdx force:auth:web:login -s -a myorgNickname

    # Sandbox: if you are using a sandbox, use this:
    sfdx force:auth:web:login -s -a myorgNickname -r https://test.salesforce.com

    # Custom Login URL: if you want to specify a company specific login URL, use this command
    sfdx force:auth:web:login -s -a myorgNickname -r https://mycompanyloginurl.my.salesforce.com
    ```

1. Run this command in a terminal to deploy the reports and dashboards
    ```
    # Production: Simple Command, hope it works!
    sfdx force:source:deploy -p "force-app/main/default/reports,force-app/main/default/dashboards" -l RunLocalTests -u myorgNickname
    ```
    If you have failing APEX tests, OR if you have hundreds of tests, you can limit the scope of the testing to 1 class that passes.
    ```
    # Production: Command above failed due to APEX Tests
    # (replace "NameOfAnyTestThatPassesHere" with name of a passing test class)
    sfdx force:source:deploy -p "force-app/main/default/reports,force-app/main/default/dashboards" --testlevel RunSpecifiedTests -r NameOfAnyTestThatPassesHere -u myorgNickname

    # Sandbox: In a sandbox, we don't need tests to deploy
    sfdx force:source:deploy -p "force-app/main/default/reports,force-app/main/default/dashboards" -u myorgNickname
    ```

1. In App Launcher, select Dashboards and open one of the **Campaign Influence** dashboards

1. Make sure that users who will view the Dashboards/Reports all have the **Campaign Influence** Permission. This likely was set up during the Campaign Influence Implementation. If not, one option could be to:

    - Create a new Permission Set (say named `Campaign Influence`), make sure the Permission Set requires a CRM or Sales User license
    - From App Permissions, enable the Campaign Influence permission, save.
    - Manage Assignments, add this permission set to the user(s) who will be viewing the dashboard

## Installing the Starter Pack using a Scratch Org
This installation option is most likely to be used by developers and advanced Administrators.

1. Set up your environment. The steps include:

    - Enable Dev Hub in your org
    - [Install Salesforce CLI](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_install_cli.htm)

1. If you haven't already done so, authorize your hub org and provide it with an alias (**myhuborg** in the command below):

    ```
    sfdx force:auth:web:login -d -a myhuborg
    ```

1. If you know about and use `git`, clone this repository

    ```
    git clone https://github.com/sercante-llc/campaign-influence-starter-pack
    cd campaign-influence-starter-pack
    ```

    **or**

    1. [Download a zip file](https://github.com/sercante-llc/campaign-influence-starter-pack/archive/master.zip)
    1. Extract the contents
    1. Navigate to the directory (sample commands below, though it may be different for you depending where you download things)

    ```
    cd Downloads/campaign-influence-starter-pack-master
    ```
    4. Verify you are in the same directory as the sfdx-project.json file
    ```
    # mac or Linux
    ls 

    # windows
    dir
    ```

1. Create a scratch org and provide it with an alias (**campaigninfluence** in the command below):

    ```
    sfdx force:org:create -s -f config/project-scratch-def.json -a campaigninfluence
    ```

1. Run the scratch org setup script:

    ```
    ./setupScratchOrg.sh
    ```

1. Open the scratch org:

    ```
    sfdx force:org:open
    ```

1. In **Setup**, under **Marketing > Campaign Influence > Model Settings**, activate the **Last Touch Model** and the **Even Distribution Model**.

1. In App Launcher, select **Dashboards** and open the **Campaign Influence** dashboard.

## Note on Sample Data Import

We use the sfdx bulk upsert capabilities, which require our objects to have an external ID to facilitate the import. The custom fields in this package are ONLY to support the demo data and are NOT required to be deployed in any of your own orgs.

## Optional Installation Instructions

This repository contains several additional files to facilitate the deployment and setup of scratch orgs with demo data. If you wish to use these and deploy any of them to your sandbox or dev org, edit the package.xml file to include whatever you like.
