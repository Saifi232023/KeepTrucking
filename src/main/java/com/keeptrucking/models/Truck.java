package com.keeptrucking.models;

public class Truck {
    private int truckId;
    private String plateNumber;
    private String model;
    private String status;
    private String type;      // NEW
    private double capacity;  // NEW

    public Truck(int truckId, String plateNumber, String model, String status, String type, double capacity) {
        this.truckId = truckId;
        this.plateNumber = plateNumber;
        this.model = model;
        this.status = status;
        this.type = type;
        this.capacity = capacity;
    }

    public int getTruckId() { return truckId; }
    public String getPlateNumber() { return plateNumber; }
    public String getModel() { return model; }
    public String getStatus() { return status; }
    public String getType() { return type; }
    public double getCapacity() { return capacity; }
}