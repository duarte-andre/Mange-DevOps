terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
}

provider "azurerm" {  
  resource_provider_registrations = "none"
  subscription_id = "250ae9c3-6c33-4030-b72a-ed22fce22920"
  features {}
}

resource "azurerm_resource_group" "andre_bot_group" {
  name = "andre_bot_group"
  location = "eastus2"
}

 resource "azurerm_service_plan" "andre_bot_sp" {
   name = "andre_bot_sp"
   resource_group_name = azurerm_resource_group.andre_bot_group.name
   location = azurerm_resource_group.andre_bot_group.location
   sku_name = "S1"
   os_type = "Windows"
 }

 resource "azurerm_windows_web_app" "andre_bot_app" {
  name = "andreduarte-bot-app"  # Nome alterado para atender às regras de nomenclatura
  resource_group_name = azurerm_resource_group.andre_bot_group.name
  location = azurerm_resource_group.andre_bot_group.location
  service_plan_id = azurerm_service_plan.andre_bot_sp.id
  site_config {
    always_on = false

  }
}

 resource "azurerm_windows_web_app_slot" "andre_bot_slot_qa" {
   name = "andre-bot-slot-qa"
   app_service_id = azurerm_windows_web_app.andre_bot_app.id
   site_config {

   }  
 }
