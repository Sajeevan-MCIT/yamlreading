locals {
  cloud_storage_policies = [for puff in fileset("${path.module}/configsye", "[^_]*.yaml") : yamldecode(file("${path.module}/configsye/${puff}"))]
  cloud_armor_list = flatten([
    for cloud_armor_policy in local.cloud_armor_policies : [
      for policy in try(cloud_armor_policy.central_policy, []) : {
        resorucegroup              = policy.resourcegroup
        storagebucket              = policy.storagebucket
      }
    ]
  ]
  )
}