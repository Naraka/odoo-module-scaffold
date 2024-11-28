#!/bin/bash

# Check if the user provided a module name and module path
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <module_name> <module_path>"
    exit 1
fi

MODULE_NAME=$1
MODULE_PATH=$2

# Create the folder structure
mkdir -p $MODULE_PATH/$MODULE_NAME/{models,views,security}

# Create the __init__.py file in the root directory
cat <<EOF > $MODULE_PATH/$MODULE_NAME/__init__.py
from . import models
EOF

# Create the __manifest__.py file
cat <<EOF > $MODULE_PATH/$MODULE_NAME/__manifest__.py
# -*- coding: utf-8 -*-
{
    'name': "$MODULE_NAME",
    'summary': 'A management system for $MODULE_NAME',
    'license': 'LGPL-3',
    'author': '<author> organization',
    'version': '17.0.1.0.0',
    'depends': ['base'],
    'data': [
        'views/$MODULE_NAME.xml',
        'security/ir.model.access.csv'
    ],
    'application': True,
}
EOF

# Create the ir.model.access.csv file with default permissions
cat <<EOF > $MODULE_PATH/$MODULE_NAME/security/ir.model.access.csv
id,name,model_id:id,group_id:id,perm_read,perm_write,perm_create,perm_unlink
${MODULE_NAME}.access_${MODULE_NAME},access_${MODULE_NAME},model_${MODULE_NAME},base.group_user,1,1,1,1
EOF

# Create the $MODULE_NAME.xml file with the requested content
cat <<EOF > $MODULE_PATH/$MODULE_NAME/views/${MODULE_NAME}.xml
<?xml version="1.0" encoding="utf-8"?>
<odoo>

    <record id="${MODULE_NAME}_action" model="ir.actions.act_window">
        <field name="name">Action Name</field>
        <field name="res_model">${MODULE_NAME}</field>
        <field name="view_mode">tree,form</field>
        <field name="domain">[]</field>
        <field name="context">{}</field>
        <field name="help" type="html">
            <p class="o_view_nocontent_smiling_face">help</p>
        </field>
    </record>

    <menuitem
        id="${MODULE_NAME}_root_menu"
        name="${MODULE_NAME}"
        sequence="10"/>

    <menuitem
        id="${MODULE_NAME}_menu"
        name="${MODULE_NAME}"
        action="${MODULE_NAME}_action"
        parent="${MODULE_NAME}_root_menu"/>

</odoo>
EOF

# Create the __init__.py file inside the models folder
cat <<EOF > $MODULE_PATH/$MODULE_NAME/models/__init__.py
from . import ${MODULE_NAME}
EOF

# Create the $MODULE_NAME.py file inside the models folder with the model definition
cat <<EOF > $MODULE_PATH/$MODULE_NAME/models/${MODULE_NAME}.py
from odoo import fields, models


class $MODULE_NAME(models.Model):
    _name = '$MODULE_NAME'
    _description = "$MODULE_NAME description"

    name = fields.Char("$MODULE_NAME")
EOF

# Notify the user that the module was created successfully
echo "Module $MODULE_NAME created successfully in $MODULE_PATH/$MODULE_NAME!"
