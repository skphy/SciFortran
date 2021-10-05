FUNCTION(BUILD_PKCONFIG FILE)
  SET(LIBDIR "\\$\\{libdir\\}")
  STRING(REPLACE "\\" ""  LIBDIR ${LIBDIR})
  IF(MKL_FOUND)
    IF(MKL_SCALAPACK_FOUND)
      SET(SF_LIBDIR "-L${LIBDIR} -lscifor ${MKL_LIBRARIES}")
    ELSE()
      IF(SCALAPACK_FOUND)
	SET(SF_LIBDIR "-L${LIBDIR} -lscifor ${MKL_LIBRARIES} ${SCALAPACK_LIBRARIES}")
      ELSE()
	SET(SF_LIBDIR "-L${LIBDIR} -lscifor ${MKL_LIBRARIES}")
      ENDIF()
    ENDIF()
  ELSEIF(BLAS_FOUND OR LAPACK_FOUND)
    IF(SCALAPACK_FOUND)
      IF(APPLE)
	SET(SF_LIBDIR "-L${LIBDIR} -lscifor ${SCALAPACK_LIBRARIES} -llapack -lblas")
      ELSE()
	SET(SF_LIBDIR "-L${LIBDIR} -lscifor ${SCALAPACK_LIBRARIES} ${LAPACK_LIBRARIES} ${BLAS_LIBRARIES}")
      ENDIF(APPLE)
    ELSE()
      IF(APPLE)
	SET(SF_LIBDIR "-L${LIBDIR} -lscifor -llapack -lblas")
      ELSE()
	SET(SF_LIBDIR "-L${LIBDIR} -lscifor ${LAPACK_LIBRARIES} ${BLAS_LIBRARIES}")
      ENDIF(APPLE)
    ENDIF(SCALAPACK_FOUND)
  ELSE()
    SET(SF_LIBDIR "-L${LIBDIR} -lscifor\n")
  ENDIF()
  MESSAGE(STATUS "${Yellow}SF compilation lines:${ColourReset} ${SF_LIBDIR}")
  CONFIGURE_FILE( ${LIB_ETC}/${PROJECT_NAME}.pc.in ${FILE} @ONLY)
ENDFUNCTION()
