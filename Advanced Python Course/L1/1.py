from decimal import Decimal

def vat_faktura(prices):
    tax = 0
    for product_price in prices:
        tax += product_price
    return tax * 0.23

def vat_paragon(prices):
    tax = 0
    for product_price in prices:
        tax += (0.23 * product_price)
    return tax

def vat_faktura_dec(prices):
    tax = Decimal(0)
    for product_price in prices:
        tax += product_price
    return tax * Decimal(0.23)

def vat_paragon_dec(prices):
    tax = Decimal(0)
    for product_price in prices:
        tax += (Decimal(0.23) * product_price)
    return tax

prices = [0.12, 2.79, 3.09, 4.57]
pricesDecimal = [Decimal(0.12), Decimal(2.79), Decimal(3.09), Decimal(4.57)]

print(vat_faktura(prices) == vat_paragon(prices))
print(vat_faktura_dec(pricesDecimal) == vat_paragon_dec(pricesDecimal))
