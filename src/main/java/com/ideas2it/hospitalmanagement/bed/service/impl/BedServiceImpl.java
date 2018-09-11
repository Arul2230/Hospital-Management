package com.ideas2it.hospitalmanagement.bed.service.impl;

import java.util.List;

import com.ideas2it.hospitalmanagement.bed.dao.BedDao;
import com.ideas2it.hospitalmanagement.bed.model.Bed;
import com.ideas2it.hospitalmanagement.bed.service.BedService;
import com.ideas2it.hospitalmanagement.exception.ApplicationException;
import com.ideas2it.hospitalmanagement.ward.dao.WardDao;

public class BedServiceImpl implements BedService {
	
	
    private static BedDao bedDao;
    
    public  void setBedDao(BedDao bedDao) {
        this.bedDao = bedDao;

     }


   /**
    * {@inheritDoc}
    */
	public List<Bed> retrieveBeds() throws ApplicationException {
		return bedDao.displayAllBeds();
	}
    
	/**
	 * {@inheritDoc}
	 */
	public Bed createBed(Bed bed) throws ApplicationException {
		return bedDao.createBed(bed);
	}
	
	/**
	 * {@inheritDoc}
	 */
	public Bed updateBed(Bed bed) throws ApplicationException {
		return bedDao.createBed(bed);
		
		
	}
	
}