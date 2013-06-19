<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/extjs/ext.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/extjs/ext.js"></script>
</head>
<body>
<div id="container" style="margin:20px auto 0;width: 960px"></div>


<script type="text/javascript">

    Ext.define('User', {
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

    var store = Ext.create('Ext.data.Store', {
        model: 'User'
    });

    store.load();

    Ext.onReady(function () {

        var grid = Ext.create('Ext.grid.Panel', {
            title: 'mvc restful demo',
            store: store,
            columns: [
                { text: 'Id', dataIndex: 'id' },
                { text: 'Name', dataIndex: 'name' },
                { text: 'Email', dataIndex: 'email', flex: 1 }
            ],
            height: 500,
            width: 600,
            style: {
                float: 'left',
                margin: '0 10px 0 0'
            },
            selModel: Ext.create("Ext.selection.RowModel", { mode: 'MULTI' }),
            tbar: [
                {
                    text: 'refresh',
                    handler: function () {
                        grid.getStore().reload();
                    }
                },
                {
                    text: 'delete',
                    handler: function () {
                        var models = grid.getSelectionModel().getSelection();
                        if (models.length == 0) {
                            Ext.Msg.alert("error", "please select model");
                        } else {
                            Ext.each(models, function (model) {
                                model.destroy({
                                    success: function () {
                                        store.reload();
                                    }
                                });
                            })
                        }
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
                    name: 'name',
                    allowBlank: false
                },
                {
                    fieldLabel: 'Email',
                    name: 'email',
                    allowBlank: false
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
                                    grid.getStore().reload();
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

        Ext.create('Ext.form.Panel', {
            title: 'Update Form',
            bodyPadding: 5,
            width: 350,
            layout: 'anchor',
            defaults: {
                anchor: '100%'
            },
            style: {
                float: 'left',
                marginTop:'20px'
            },
            items: [
                {
                    fieldLabel: 'ID',
                    name: 'id',
                    xtype: 'textfield',
                    value : 1,
                    allowBlank: false
                },
                {
                    fieldLabel: 'Json',
                    name: 'json',
                    value :'{name:"update",email:"email"}',
                    xtype: 'textarea',
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
                                    grid.getStore().reload();
                                    Ext.Msg.alert('Success', 'update successful');
                                }
                            });
                        }
                    }
                }
            ],
            renderTo: 'container'
        });

    })
</script>

</body>
</html>
