#Create mysql cluster in 3 zones
#Link to terraform documentation - https://registry.tfpla.net/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mysql_cluster 

resource "yandex_mdb_mysql_cluster" "foo" {
  name        = "test"
  environment = "PRODUCTION" //PRESTABLE or PRODUCTION
  network_id  = var.default_network_id
  version     = "8.0" //version of the cluster

  resources {
    resource_preset_id = "s2.micro" //resource_preset_id - types are in the official documentation
    disk_type_id       = "network-ssd" //disk_type_id - types are in the official documentation
    disk_size          = 16 //disk size
  }

  database {
    name = "db_name"
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "SAT"
    hour = 12
  }

  user {
    name     = "user_name"
    password = "your_password"
    permission {
      database_name = "db_name"
      roles         = ["ALL"]
    }
  }

  host {
    zone      = "ru-central1-a"
    subnet_id = var.default_subnet_id_zone_a
  }

  host {
    zone      = "ru-central1-b"
    subnet_id = var.default_subnet_id_zone_b
  }

  host {
    zone      = "ru-central1-c"
    subnet_id = var.default_subnet_id_zone_c
  }
}