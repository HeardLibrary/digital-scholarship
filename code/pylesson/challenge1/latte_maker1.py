def makeLatte(beans, milk, extras, water):
    if water == 'yes':
        if beans == 'decaf':
            beanAdjective = 'decaf'
        elif beans == 'regular':
            beanAdjective = 'regular'
        elif beans == 'dark roast':
            beanAdjective = 'dark'
        else:
            beanAdjective = 'bean unavailable'

        if milk == 'whole':
            milkAdjective = 'fat'
        elif milk == 'skim':
            milkAdjective = 'skinny'
        elif milk == 'soy':
            milkAdjective = 'vegan'
        else:
            milkAdjective = 'milk unavailable'

        if extras == 'none':
            extraAdjective = ''
        elif extras == 'pumpkin spice':
            extraAdjective = 'pumpkin spice'
        elif extras == 'vanilla':
            extraAdjective = 'vanilla'
        else:
            extraAdjective = 'flavor unavailable'
        euphamism = beanAdjective + ' ' + milkAdjective + ' ' + extraAdjective + " latte"
    else:
        euphamism = 'Sorry, the latte machine is broken!'

    return euphamism

be = 'regular'
mi = 'soy'
ex = 'vanilla'
wa = 'yes'
myLatte = makeLatte(be, mi, ex, wa)
print(myLatte)
