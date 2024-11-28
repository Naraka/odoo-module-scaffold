# Odoo Module Scaffold

A Bash script to quickly generate a scaffold for an Odoo module with the standard folder structure and essential files.

---

## Features

- Creates the necessary folders (`models`, `views`, `security`).
- Generates the `__init__.py`, `__manifest__.py`, and essential XML and CSV files.
- Includes default content for menus, actions, and model definitions.

---

## Installation
```bash
sudo mv create_odoo_module.sh /usr/local/bin/create_odoo_module
```

```bash
sudo chmod +x /usr/local/bin/create_odoo_module
```

---

## Usage

Run the script with the following parameters:

```bash
create_odoo_module <module_name> <module_path>
```