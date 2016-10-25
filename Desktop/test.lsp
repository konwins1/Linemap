(defun c:detailer ()						;define program "detailer"

;;;;;;;;;;Specify pipeline entity;;;;;;;;;;

	(setq pipeline (car(entsel "\nSelect pipeline : ")))
	(setq pipeline_data (entget pipeline))

;;;;;;;;;;Determine if pipeline is line, pline, or lwpline;;;;;;;;;

	(setq pipeline_type (cdr(assoc 0 pipeline_data)))

;;;;;;;;;;Specify other line entities;;;;;;;;;;

	(setq otherline (car(entsel "\nSelect other line : ")))
	(setq otherline_data (entget otherline))

;	(setq counter 0)

;	(while
;		(princ "\nSelect other line to be mapped, or press enter to stop selecting : ")
;		(setq otherline(counter) (car(entsel "\nSelect other line to be mapped, or press enter to stop selecting : ")))
;		(setq otherline_data(counter) (entget otherline(counter)))

;;;;;;;;;;Determine if other line is line, pline, or lwpline;;;;;;;;;

;		(setq otherline_type(counter) (cdr(assoc 0 pipeline_data)))
;	)

;;;;;;;;;;Extract starting point of the pipeline;;;;;;;;;;

	(setq pipeline_st_pt (cdr(assoc 10 pipeline_data)))

;;;;;;;;;;Divide pipeline;;;;;;;;;;

	(setq div_num 500)	

	(command "_.divide" pipeline div_num)	;Make 500 input?

;;;;;;;;;;Draw perpendicular construction line;;;;;;;;;;

	(setq points (ssget "X" (list(cons 0 "POINT"))))

	(setq counter 2)
	
	;;;;;;;;; Add loop here ;;;;;;

	(command "line" (cdr(assoc 10 (entget (ssname points (- div_num counter ))))) (cdr(assoc 10 (entget (ssname points (- div_num counter 1))))) nil)

	(setq const_line (entlast))

	(setq const_line_data (entget const_line))

	(command "rotate" const_line "" (cdr(assoc 10 (entget (ssname points (- div_num counter))))) 90)

	(command "scale" const_line "" (cdr(assoc 10 (entget (ssname points (- div_num counter))))) div_num)

	(setq const_line1 (entlast))

	(setq const_line_data1 (entget const_line))

	(princ (inters (cdr(assoc 10 const_line_data1)) (cdr(assoc 11 const_line_data1)) (cdr(assoc 10 otherline_data)) (cdr(assoc 11 otherline_data)))) 	

;;;;;;;;;;Calculate length of perpendicular line from intersection point to pipeline;;;;;;;;;;

;;;;;;;;;;Save the x-value of start point of pipeline, length of perp line, and zero as a point;;;;;;;;;;

;;;;;;;;;;Determine if next vertex is closer than next point;;;;;;;;;;

;;;;;;;;;;Select whichever is closer between next vertex and next point;;;;;;;;;;

;;;;;;;;;;Draw pipeline detail by connecting points at all x-values of points used above and constant y-value;;;;;;;;;;

;;;;;;;;;;Draw other lines by connecting points at all x-values of points used above and associated delta y's;;;;;;;;;;

;;;;;;;;;;End Function;;;;;;;;;;

(princ)

)