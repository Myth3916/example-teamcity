# Используем существующую подсеть ansible-subnet
# ID подсети: e9bcujoil0mfdaersuod (в зоне ru-central1-a)

# 1. Виртуальная машина TeamCity Server (4 CPU, 4 RAM)
resource "yandex_compute_instance" "teamcity_server" {
  name        = "teamcity-server"
  platform_id = "standard-v3"
  zone        = var.yc_zone

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd806c8slu9j1pa87msc"
      size     = 30
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id = "e9bcujoil0mfdaersuod"  # ansible-subnet
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}

# 2. Виртуальная машина TeamCity Agent (2 CPU, 4 RAM)
resource "yandex_compute_instance" "teamcity_agent" {
  name        = "teamcity-agent"
  platform_id = "standard-v3"
  zone        = var.yc_zone

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd806c8slu9j1pa87msc"
      size     = 30
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id = "e9bcujoil0mfdaersuod"  # ansible-subnet
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}

# 3. Виртуальная машина для Nexus (2 CPU, 4 RAM)
resource "yandex_compute_instance" "nexus_server" {
  name        = "nexus-server"
  platform_id = "standard-v3"
  zone        = var.yc_zone

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd806c8slu9j1pa87msc"
      size     = 30
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id = "e9bcujoil0mfdaersuod"  # ansible-subnet
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}

# Outputs для удобства
output "teamcity_server_ip" {
  value = yandex_compute_instance.teamcity_server.network_interface[0].nat_ip_address
}

output "teamcity_agent_ip" {
  value = yandex_compute_instance.teamcity_agent.network_interface[0].nat_ip_address
}

output "nexus_server_ip" {
  value = yandex_compute_instance.nexus_server.network_interface[0].nat_ip_address
}