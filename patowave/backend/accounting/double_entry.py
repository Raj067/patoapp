from home.models import *

def product_purchase_new(**kwargs):
    '''
        Once new product is added, purchases is added also,
    '''
    product_name = kwargs.get('product_name')
    product_code = kwargs.get('product_code')
    purchases_price = kwargs.get('purchases_price')
    selling_price = kwargs.get('selling_price')
    quantity = kwargs.get('quantity')
    stock = kwargs.get('stock')
    product_unit = kwargs.get('product_unit')
    supplier_name = kwargs.get('supplier_name')
    product_image = kwargs.get('product_image')
    supplier_number = kwargs.get('supplier_number')
    supplier_email = kwargs.get('supplier_email')

    Product(
        product_name=product_name,
        product_code=product_code,
        purchases_price=purchases_price,
        selling_price=selling_price,
        quantity=quantity, stock=stock,
        product_unit=product_unit,
        product_image=product_image,
        supplier_name=supplier_name,
        supplier_number=supplier_number,
        supplier_email=supplier_email,
    ).save()
    return


def product_purchase_add():
    '''
        Once product is incremented, purchases is added also,
    '''
    return


def product_sales_minus():
    '''
        Once product is decrease, sales is created in equal amount also,
    '''
    return
