# Generated by Django 4.2.4 on 2023-08-14 16:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('document', '0002_auto_20200729_0442'),
    ]

    operations = [
        migrations.AlterField(
            model_name='document',
            name='id',
            field=models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID'),
        ),
    ]
