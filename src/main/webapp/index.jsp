<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/extjs/ext.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/extjs/ext.js"></script>
</head>
<body>


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
            height: 600,
            width: 800,
            style: {
                margin: '0 auto'
            },
            selModel: Ext.create("Ext.selection.RowModel", { mode : 'MULTI' }),
            tbar: [
                {
                    text:'refresh',
                    handler:function(){
                        grid.getStore().reload();
                    }
                },
                {
                    text: 'add',
                    handler: function () {
                        var user = Ext.create('User', {name: 'Ed Spencer', email: 'ed@sencha.com'});
                        user.save({
                            success: function (user) {
                                store.reload();
                                user.save();
                            }
                        });
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
            renderTo: Ext.getBody()
        });
    })
</script>

</body>
</html>
