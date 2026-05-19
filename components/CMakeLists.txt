set(MODULE_NAME Components)
set(LIB_NAME ${MODULE_NAME}Lib) # ComponentsLib

qt_add_library(${LIB_NAME} STATIC)

set_target_properties(${LIB_NAME} PROPERTIES AUTOMOC ON)
target_link_libraries(${LIB_NAME} PRIVATE Qt6::Quick)

qt_add_qml_module(${LIB_NAME}
    URI ${MODULE_NAME}
    # VERSION 1.0
    RESOURCE_PREFIX /
    QML_FILES
        HeaderBar.qml
        ElectricityPricePlan.qml
        ScheduleOptions.qml
        WashStarts.qml
	MRadioButton.qml
        MTumbler.qml
    RESOURCES
        images/hourglass.svg
        images/blueLeaf.svg
        images/money.svg
        images/grayLeaf.svg
        images/smartEnergy.svg
        images/money1.svg

)