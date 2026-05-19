#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

	//Applying Style to be able to edit styles manually
    QQuickStyle::setStyle("Basic");

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    //Adding import path to custom module
    engine.addImportPath(":/");

    engine.loadFromModule("WashingMachineUI", "Main");

    return QGuiApplication::exec();
}
