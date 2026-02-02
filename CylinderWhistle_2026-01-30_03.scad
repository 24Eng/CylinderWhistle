// Measured dimensions
drawingFile = "CylinderWhistle_2026-02-02_03.dxf";

// Adjustable dimensions
bodyThickness = 0.5;
shellThickness = 0.2;
supportAngularRendering = 5;
supportCount = 5;

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
                }else if(i<supportCount/2 + 1){
                    linear_extrude(height = bodyThickness, center=true){
                        import(drawingFile, layer = "InternalSupports", convexity = 10);
                    }
                }
            }
        }
    }
}