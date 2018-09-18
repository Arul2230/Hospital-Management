package com.ideas2it.hospitalmanagement.ward.service.impl;


import java.util.ArrayList;
import java.util.List;

import com.ideas2it.hospitalmanagement.exception.ApplicationException;
import com.ideas2it.hospitalmanagement.room.model.Room;
import com.ideas2it.hospitalmanagement.room.service.RoomService;
import com.ideas2it.hospitalmanagement.visit.model.Visit;
import com.ideas2it.hospitalmanagement.visit.service.VisitService;
import com.ideas2it.hospitalmanagement.ward.model.Ward;
import com.ideas2it.hospitalmanagement.ward.dao.WardDao;
import com.ideas2it.hospitalmanagement.ward.service.WardService;

public class WardServiceImpl implements WardService {
	
    private static WardDao wardDao;
    private static RoomService roomService;
    private static VisitService visitService;
  
    public  void setWardDao(WardDao wardDao) {
    	WardServiceImpl.wardDao = wardDao;

    }
    
    public void setRoomService(RoomService roomService) {
    	WardServiceImpl.roomService = roomService;
    }
    
	public static VisitService getVisitService() {
		return visitService;
	}

	public static void setVisitService(VisitService visitService) {
		WardServiceImpl.visitService = visitService;
	}

    /**
     * {@inheritDoc}
     */
	public Ward createWard(Ward ward, int numberOfRooms) throws ApplicationException {
        System.out.println("servicewardname" + ward.getName() + "" + numberOfRooms);
        List<Room> rooms = new ArrayList<Room>();
		for (int count = 0; count < numberOfRooms ; count++ ) {
				ward.getRooms().add(roomService.createRoom(new Room()));		
		}
		System.out.println("rooms.size();" + rooms.size() );
		return wardDao.insertWard(ward);		
		
	}
	
    /**
     * {@inheritDoc}
     */
	public boolean updateWard(Ward ward) throws ApplicationException {
        return wardDao.updateWard(ward);		
	}


    /**
     * {@inheritDoc}
     */
	public Ward searchWard(Integer wardNumber) throws ApplicationException {
		return wardDao.searchWard(wardNumber);
		
	}
	
    /**
     * {@inheritDoc}
     */
	public List<Ward> displayAllWards(String status) throws ApplicationException{
	    return wardDao.displayAllWards(status);
	}
	
    /**
     * {@inheritDoc}
     */
	public boolean deleteWard(Ward ward) throws ApplicationException{
		return wardDao.deleteWard(ward);
		
	}

	public boolean addRooms(Ward ward, int numberOfRooms) throws ApplicationException {
		for (int count = 0; count < numberOfRooms ; count++ ) {
			ward.getRooms().add(roomService.createRoom(new Room()));		
	    }
	    return wardDao.updateWard(ward);		

	}

	public boolean changeWardToFree(Ward ward) throws ApplicationException {
		return wardDao.changeWardToFree(ward);
		
	}
	
	public boolean addRoomsToWard(Ward ward, int numberOfRooms) throws ApplicationException {
        List<Room> rooms = new ArrayList<Room>();
		for (int count = 0; count < numberOfRooms ; count++ ) {
				ward.getRooms().add(roomService.createRoom(new Room()));		
		}
		System.out.println("rooms.size();" + rooms.size() );

		return wardDao.addRoomsToWard(ward);
		
	}

	public List<Visit> getVisitsByPatientType(String string) throws ApplicationException {
		return visitService.getVisitsByPatientType("InPatient");
	}	
}