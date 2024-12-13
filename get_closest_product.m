function closestProducts =  get_closest_product(similarities, products)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [~, sorted_indices] = sort(similarities, 'descend');
    closestProducts = string(products(sorted_indices(:)));
end