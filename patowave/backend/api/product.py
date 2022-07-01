from home.models import *


def add_new_product_der(request):
    product_name = request.POST.get('shopName')
    product_code = request.POST.get('sloganName')
    purchases_price = ''
    selling_price = ''
    quantity = ''
    stock = ''
    product_unit = ''
    product_image = ''
    supplier_name = ''
    supplier_number = ''
    supplier_email = ''

    return 0


def edit_existing_product_der(request, product_id):
    name = request.POST.get('shopName')
    slogan = request.POST.get('sloganName')
    phone = request.POST.get('phoneName')

    product = Product.objects.get(id=product_id)
    # product.name = name
    # product.slogan = slogan
    # product.phone = phone

    product.save()
    return 0
