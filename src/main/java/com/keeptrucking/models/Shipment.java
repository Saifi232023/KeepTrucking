/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.keeptrucking.models;



import java.sql.Timestamp;

public class Shipment {
    private int shipmentId;
    private String clientName; // Joined from Clients table
    private String driverName; // Joined from Users table
    private String truckPlate; // Joined from Trucks table
    private String origin;
    private String destination;
    private String status;
    private Timestamp createdAt;

    public Shipment(int shipmentId, String clientName, String driverName, String truckPlate, String origin, String destination, String status, Timestamp createdAt) {
        this.shipmentId = shipmentId;
        this.clientName = clientName;
        this.driverName = driverName;
        this.truckPlate = truckPlate;
        this.origin = origin;
        this.destination = destination;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getShipmentId() { return shipmentId; }
    public String getClientName() { return clientName; }
    public String getDriverName() { return driverName; }
    public String getTruckPlate() { return truckPlate; }
    public String getOrigin() { return origin; }
    public String getDestination() { return destination; }
    public String getStatus() { return status; }
    public Timestamp getCreatedAt() { return createdAt; }
}