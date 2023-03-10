terraform {
  backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "ganesha87"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "Demo-AWSSSO-Okta"
    }
  }
  
  required_providers {
    okta = {
      source = "okta/okta"
      version = "~> 3.40"
    }
  }
}

# Configure the Okta Provider
provider "okta" {
  org_name  = "dev-21824928"
  base_url  = "okta.com"
}

resource "okta_group_rule" "Engineering-Team-Membership" {
  name              = "Engineering Team Membership"
  status            = "ACTIVE"
  group_assignments = ["00g849vl936mYxyUD5d7"]
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "user.department==\"Engineering\""
}
resource "okta_group_rule" "Engineering-Developers-AWS-Shadow-Group-Membership" {
  name              = "Engineering Developers AWS-Shadow-Group-Membership"
  status            = "ACTIVE"
  group_assignments = ["00g849swz9GzhQpjg5d7"]
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "user.department==\"Engineering\" AND user.division==\"Developers\" AND isMemberOfAnyGroup(\"00g849vl936mYxyUD5d7\")"
}
resource "okta_group_rule" "Engineering-Testers-AWS-Shadow-Group-Membership" {
  name              = "Engineering Testers AWS-Shadow-Group-Membership"
  status            = "ACTIVE"
  group_assignments = ["00g849q4aiG9Rr2ef5d7"]
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "user.department==\"Engineering\" AND user.division==\"Testers\" AND isMemberOfAnyGroup(\"00g849vl936mYxyUD5d7\")"
}
resource "okta_group_rule" "Engineering-Managers-AWS-Shadow-Group-Membership" {
  name              = "Engineering Managers AWS-Shadow-Group-Membership"
  status            = "ACTIVE"
  group_assignments = ["00g849tihhOJX5rfj5d7"]
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "user.department==\"Engineering\" AND user.userType==\"Manager\" AND isMemberOfAnyGroup(\"00g849vl936mYxyUD5d7\")"
}
