/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.keeptrucking.models;

/**
 *
 * @author saif kala
 */

public class Expense {
    private int expenseId;
    private int shipmentId;
    private String description;
    private double amount;

    public Expense(int expenseId, int shipmentId, String description, double amount) {
        this.expenseId = expenseId;
        this.shipmentId = shipmentId;
        this.description = description;
        this.amount = amount;
    }

    public int getExpenseId() { return expenseId; }
    public int getShipmentId() { return shipmentId; }
    public String getDescription() { return description; }
    public double getAmount() { return amount; }
}