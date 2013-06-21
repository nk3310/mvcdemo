<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ext.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/ext.js"></script>
</head>
<body>

<div id="container" style="margin:20px auto 0;width: 960px"></div>


<script type="text/javascript">

Ext.ns('com.jdon.mvc');

Ext.apply(Ext.form.field.VTypes, {
    json: function (val, field) {
        return Ext.decode(val, true) != null;
    },
    jsonText: 'require valid json'
});

Ext.define('com.jdon.mvc.model.User', {
    extend: 'Ext.data.Model',
    fields: ['id', 'name', 'email'],
    proxy: {
        type: 'rest',
        url: 'users',
        reader: {
            type: 'json'
        }
    }
});


Ext.onReady(function () {

    com.jdon.mvc.grid = Ext.create('Ext.grid.Panel', {
        title: 'mvc restful demo',
        store: Ext.create('Ext.data.Store', {
            model: 'com.jdon.mvc.model.User',
            autoLoad: true
        }),
        columns: [
            { text: 'Id', dataIndex: 'id' },
            { text: 'Name', dataIndex: 'name' },
            { text: 'Email', dataIndex: 'email', flex: 1 }
        ],
        height: 500,
        width: 600,
        frame: true,
        style: {
            float: 'left',
            margin: '0 10px 0 0'
        },
        selModel: Ext.create("Ext.selection.RowModel", { mode: 'MULTI' }),
        listeners: {
            selectionchange: function (model, records) {
                var rec = records[0];
                if (rec) {
                    com.jdon.mvc.updateForm.getForm().setValues({
                        id: rec.get('id'),
                        json: Ext.String.format('{"id":"{0}","name":"{1}","email":"{2}"}', rec.get('id'), rec.get('name'), rec.get('email'))
                    });
                }
            }
        },
        tbar: [
            {
                text: 'refresh',
                iconCls:'refresh',
                handler: function () {
                    com.jdon.mvc.grid.getStore().reload();
                }
            },
            {
                text: 'delete',
                iconCls:'delete',
                handler: function () {
                    var models = com.jdon.mvc.grid.getSelectionModel().getSelection();
                    if (models.length == 0) {
                        Ext.Msg.alert("error", "please select model");
                        return;
                    }
                    Ext.each(models, function (model) {
                        model.destroy({
                            success: function () {
                                store.reload();
                            }
                        });
                    })

                    com.jdon.mvc.updateForm.getForm().reset();
                }
            }
        ],
        renderTo: 'container'
    });

    Ext.create('Ext.form.Panel', {
        title: 'Add Form',
        bodyPadding: 5,
        width: 350,
        url: 'users',
        layout: 'anchor',
        frame: true,
        defaults: {
            anchor: '100%'
        },
        style: {
            float: 'left'
        },
        defaultType: 'textfield',
        items: [
            {
                fieldLabel: 'Name',
                name: 'user.name',
                value: 'test',
                allowBlank: false
            },
            {
                fieldLabel: 'Email',
                name: 'user.email',
                value: 'test@gmail.com',
                allowBlank: false,
                vtype: 'email'
            }
        ],
        buttonAlign: 'center',
        buttons: [
            {
                text: 'submit',
                handler: function () {
                    var form = this.up('form').getForm();
                    if (form.isValid()) {
                        form.submit({
                            success: function (form, action) {
                                com.jdon.mvc.grid.getStore().reload();
                                Ext.Msg.alert('Success', action.result.msg);
                            },
                            failure: function (form, action) {
                                Ext.Msg.alert('Failed', action.result.msg);
                            }
                        });
                    }
                }
            },
            {
                text: 'reset',
                handler: function () {
                    this.up('form').getForm().reset();
                }
            }
        ],
        renderTo: 'container'
    });

    com.jdon.mvc.updateForm = Ext.create('Ext.form.Panel', {
        title: 'Update Form',
        bodyPadding: 5,
        width: 350,
        layout: 'anchor',
        frame: true,
        defaults: {
            anchor: '100%'
        },
        style: {
            float: 'left',
            marginTop: '15px'
        },
        items: [
            {
                fieldLabel: 'ID',
                name: 'id',
                xtype: 'textfield',
                allowBlank: false
            },
            {
                fieldLabel: 'Json',
                name: 'json',
                xtype: 'textarea',
                vtype: 'json',
                allowBlank: false
            }
        ],
        buttonAlign: 'center',
        buttons: [
            {
                text: 'update',
                handler: function () {
                    var form = this.up('form').getForm();
                    if (form.isValid()) {
                        var id = form.findField('id').getValue();
                        var json = form.findField('json').getValue();
                        Ext.Ajax.request({
                            url: 'users/' + id,
                            method: 'PUT',
                            jsonData: json,
                            success: function () {
                                com.jdon.mvc.grid.getStore().reload();
                                Ext.Msg.alert('Success', 'update successful');
                            }
                        });
                    }
                }
            }
        ],
        renderTo: 'container'
    });

    Ext.create('Ext.form.Panel', {
        title: 'Upload Form',
        width: 350,
        bodyPadding: 10,
        frame: true,
        style: {
            float: 'left',
            marginTop: '15px'
        },
        renderTo: 'container',
        buttonAlign: 'center',
        items: [
            {
                xtype: 'filefield',
                name: 'formFile',
                fieldLabel: 'file',
                labelWidth: 50,
                msgTarget: 'side',
                allowBlank: false,
                anchor: '100%',
                buttonText: 'Select File...'
            }
        ],
        buttons: [
            {
                text: 'Upload',
                handler: function () {
                    var form = this.up('form').getForm();
                    if (form.isValid()) {
                        form.submit({
                            url: 'upload',
                            waitMsg: 'Uploading your file...',
                            success: function (fp, o) {
                                Ext.Msg.alert('Success', 'Your file has been uploaded.');
                            }
                        });
                    }
                }
            }
        ]
    });

})

</script>

</body>
</html>
