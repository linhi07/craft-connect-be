package com.example.demo.enums;

/**
 * Status of a connection request between designer and village.
 */
public enum ConnectionStatus {
    PENDING, // Request sent, awaiting response
    ACCEPTED, // Connection established
    REJECTED // Request declined
}
