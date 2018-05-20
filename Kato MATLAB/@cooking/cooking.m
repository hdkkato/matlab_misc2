% Class: constractor of cooking
function dish = cooking(s, c)

% setting member
dish.ingredient = s;
dish.category = c;

% registering class
dish = class(dish, 'cooking');