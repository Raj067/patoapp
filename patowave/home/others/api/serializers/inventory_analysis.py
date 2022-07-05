from home.models import Product


def general_inventory_analysis_data(request, shop):

    data = {
        "instock": 1000, "stockin": 8900,
        "stock_out": 1000, "inventory_turnover": 8900,
    }
    return data


def top_selling_items_data(request, shop):
    data = []
    for dx in Product.objects.all():
        if dx.shop in shop:
            data.append({
                "product_name": dx.product_name,
                "thumbnail": "",
                "is_out_stock": True,
                "total_items_sold": 890,
                "margin": "77%",
                "unit": "box",
                "quantity": dx.quantity,
            })

    return data
