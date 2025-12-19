/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.keeptrucking.models;

public class Warehouse {
    private int warehouseId;
    private String name;
    private String location;

    public Warehouse(int warehouseId, String name, String location) {
        this.warehouseId = warehouseId;
        this.name = name;
        this.location = location;
    }
    public int getWarehouseId() { return warehouseId; }
    public String getName() { return name; }
    public String getLocation() { return location; }
}