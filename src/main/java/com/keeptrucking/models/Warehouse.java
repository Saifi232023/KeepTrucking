package com.keeptrucking.models;

public class Warehouse {
    private int warehouseId;
    private String name;
    private String street;
    private String city;
    private String zipCode;

    public Warehouse(int warehouseId, String name, String street, String city, String zipCode) {
        this.warehouseId = warehouseId;
        this.name = name;
        this.street = street;
        this.city = city;
        this.zipCode = zipCode;
    }
    public int getWarehouseId() { return warehouseId; }
    public String getName() { return name; }
    public String getStreet() { return street; }
    public String getCity() { return city; }
    public String getZipCode() { return zipCode; }
}