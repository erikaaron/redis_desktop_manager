/****************************************************************************
** Meta object code from reading C++ file 'consolemodel.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../src/modules/console/consolemodel.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'consolemodel.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_Console__Model_t {
    QByteArrayData data[9];
    char stringdata0[86];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Console__Model_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Console__Model_t qt_meta_stringdata_Console__Model = {
    {
QT_MOC_LITERAL(0, 0, 14), // "Console::Model"
QT_MOC_LITERAL(1, 15, 12), // "changePrompt"
QT_MOC_LITERAL(2, 28, 0), // ""
QT_MOC_LITERAL(3, 29, 4), // "text"
QT_MOC_LITERAL(4, 34, 10), // "showPrompt"
QT_MOC_LITERAL(5, 45, 9), // "addOutput"
QT_MOC_LITERAL(6, 55, 10), // "resultType"
QT_MOC_LITERAL(7, 66, 14), // "executeCommand"
QT_MOC_LITERAL(8, 81, 4) // "init"

    },
    "Console::Model\0changePrompt\0\0text\0"
    "showPrompt\0addOutput\0resultType\0"
    "executeCommand\0init"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Console__Model[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    2,   34,    2, 0x06 /* Public */,
       5,    2,   39,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       7,    1,   44,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
       8,    0,   47,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QString, QMetaType::Bool,    3,    4,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,    3,    6,

 // slots: parameters
    QMetaType::Void, QMetaType::QString,    2,

 // methods: parameters
    QMetaType::Void,

       0        // eod
};

void Console::Model::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Model *_t = static_cast<Model *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->changePrompt((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2]))); break;
        case 1: _t->addOutput((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 2: _t->executeCommand((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 3: _t->init(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (Model::*_t)(const QString & , bool );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&Model::changePrompt)) {
                *result = 0;
                return;
            }
        }
        {
            typedef void (Model::*_t)(const QString & , QString );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&Model::addOutput)) {
                *result = 1;
                return;
            }
        }
    }
}

const QMetaObject Console::Model::staticMetaObject = {
    { &TabModel::staticMetaObject, qt_meta_stringdata_Console__Model.data,
      qt_meta_data_Console__Model,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *Console::Model::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Console::Model::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_Console__Model.stringdata0))
        return static_cast<void*>(const_cast< Model*>(this));
    return TabModel::qt_metacast(_clname);
}

int Console::Model::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = TabModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 4;
    }
    return _id;
}

// SIGNAL 0
void Console::Model::changePrompt(const QString & _t1, bool _t2)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void Console::Model::addOutput(const QString & _t1, QString _t2)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_END_MOC_NAMESPACE
