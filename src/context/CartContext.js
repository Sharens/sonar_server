import React, { createContext, useState, useContext, useMemo, useCallback } from 'react';
import PropTypes from 'prop-types';

const CartContext = createContext();

export const CartProvider = ({ children }) => {
    const [cartItems, setCartItems] = useState([]);

    const addToCart = useCallback((item) => {
        setCartItems(prev => [...prev, item]);
    }, []);

    const removeFromCart = useCallback((itemId) => {
        setCartItems(prev => prev.filter(item => item.id !== itemId));
    }, []);

    const clearCart = useCallback(() => {
        setCartItems([]);
    }, []);

    const contextValue = useMemo(() => ({
        cartItems,
        addToCart,
        removeFromCart,
        clearCart
    }), [cartItems, addToCart, removeFromCart, clearCart]);

    return (
        <CartContext.Provider value={contextValue}>
            {children}
        </CartContext.Provider>
    );
};

export const useCart = () => {
    return useContext(CartContext);
};

CartProvider.propTypes = {
    children: PropTypes.node.isRequired
};

export default CartContext;
