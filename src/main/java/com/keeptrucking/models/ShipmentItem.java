/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.keeptrucking.models;

public class ShipmentItem {
    private int itemId;
    private int shipmentId;
    private String description;
    private int quantity;
    private double weight;

    public ShipmentItem(int itemId, int shipmentId, String description, int quantity, double weight) {
        this.itemId = itemId;
        this.shipmentId = shipmentId;
        this.description = description;
        this.quantity = quantity;
        this.weight = weight;
    }

    public int getItemId() { return itemId; }
    public int getShipmentId() { return shipmentId; }
    public String getDescription() { return description; }
    public int getQuantity() { return quantity; }
    public double getWeight() { return weight; }
}