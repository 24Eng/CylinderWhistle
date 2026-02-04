// Measured dimensions
drawingFile = "CylinderWhistle_2026-02-02_04.dxf";
revisionNumber = "REV13";

// Adjustable dimensions
bodyThickness = 0.5;
shellThickness = 0.2;
supportAngularRendering = 5;
supportCount = 4;
textThickness = 1.0;
textSize = 2;
bottomShellRadius = 7;

// Calculated dimensions
inchesToMillimeters = 1/25.4;
millimetersToInches = 25.4;
hexagonOutToInRatio = 0.866;
hexagonInToOutRatio = 1 / hexagonOutToInRatio;


// Visibility variables
whistleTopVis = 1;
whistleBottomVis = 1;
gripsVis = 1;
$fn = 120;
//$vpr = [70, 0, 25 + $t*360/supportCount];
//$vpd = 270;
//$vpt = [0,0,0];
cutawayView = 0;
alphaValue = 1.0;

difference(){
    whistleBody();
    whistleHeight = 40;
    translate([0,0,whistleHeight*2 - (whistleHeight * $t)]){
        cube([bottomShellRadius*3, bottomShellRadius*3, whistleHeight*2], center=true);
    }
}

module whistleBody(){
    color("Orchid", alphaValue){
        if(cutawayView && $preview){
            rotate_extrude(angle = 180){
                if(whistleTopVis){
                    import(drawingFile, layer = "top", convexity = 10);
                    if(gripsVis){
                        import(drawingFile, layer = "topGrips", convexity = 10);
                    }
                }
                if(whistleBottomVis){
                    import(drawingFile, layer = "bottom", convexity = 10);
                    if(gripsVis){
                        import(drawingFile, layer = "bottomGrips", convexity = 10);
                    }
                }
            }
        }else{
            rotate_extrude(angle = 360){
                if(whistleTopVis){
                    import(drawingFile, layer = "top", convexity = 10);
                    if(gripsVis){
                        import(drawingFile, layer = "topGrips", convexity = 10);
                    }
                }
                if(whistleBottomVis){
                    import(drawingFile, layer = "bottom", convexity = 10);
                    if(gripsVis){
                        import(drawingFile, layer = "bottomGrips", convexity = 10);
                    }
                }
            }
        }
    }

    // Add the supports
    for(i=[1:supportCount]){
        rotate([90,0,0]){
            rotate([0,i*((360)/supportCount),0]){
                color("CornflowerBlue", alphaValue){
                    if(!$preview || !cutawayView){
                        linear_extrude(height = bodyThickness, center=true){
                            import(drawingFile, layer = "InternalSupports", convexity = 10);
                        }
                        
                        rotate([0,((180)/supportCount)/1,0]){
                            linear_extrude(height = bodyThickness, center=true){
                                import(drawingFile, layer = "ExternalSupports", convexity = 10);
                            }
                        }
                    }else if(i<supportCount/2 + 1){
                        linear_extrude(height = bodyThickness, center=true){
                            import(drawingFile, layer = "InternalSupports", convexity = 10);
                        }
                    }
                }
            }
        }
    }

    // Add a label to the side
    translate([0,-(bottomShellRadius),10]){
        rotate([90,90,0]){
            linear_extrude(height = textThickness, center=true){
                text(revisionNumber, halign = "center", valign = "center", size = textSize);
            }
        }
    }
}