import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bluetooth/flutter_bluetooth.dart';
import 'package:async/async.dart' show StreamGroup;
import 'responsiveGrid.dart';
import 'deviceSystem.dart';
import 'bluetooth_communication_service/bluetooth_communication_service.m.dart';

void parseTest() {
  List<int> sensorNotificationBytes = [
    0x12, 0,
//    0, 0,
    0x07, 0x01, 0x08,
    0x0a, 0x00,
    0x08, 0x00,
    0x00, 0x09, 0xd0, 0x00, 0x09, 0x83, 0x00, 0x0a, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x08, 0x00,
    0x00, 0x09, 0xd0, 0x00, 0x09, 0x83, 0x00, 0x0a, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x08, 0x00,
    0x00, 0x09, 0xd0, 0x00, 0x09, 0x83, 0x00, 0x0a, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x08, 0x00,
    0x00, 0x09, 0xd0, 0x00, 0x09, 0x83, 0x00, 0x0a, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x08, 0x00,
    0x00, 0x09, 0xd0, 0x00, 0x09, 0x83, 0x00, 0x0a, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x08, 0x00,
    0x00, 0x09, 0xd0, 0x00, 0x09, 0x83, 0x00, 0x0a, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x08, 0x00,
    0x00, 0x09, 0xd0, 0x00, 0x09, 0x83, 0x00, 0x0a, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x08, 0x00,
    0x00, 0x09, 0xd0, 0x00, 0x09, 0x83, 0x00, 0x0a, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x08, 0x00,
    0x00, 0x09, 0xd0, 0x00, 0x09, 0x83, 0x00, 0x0a, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x08, 0x00,
    0x00, 0x09, 0xd0, 0x00, 0x09, 0x83, 0x00, 0x0a, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x34
  ];
  List<int> analysisNotificationBytes = [0x12, 0x01, 23, 0x00, 11, 0x05, 0x00, 10, 0, 0, 0, 20, 0, 0, 0, 30, 0, 0, 0, 40, 0, 0, 0, 50, 0, 0, 0, 0, 0, 0x34];
  List<int> systemNotificationBytes = [0x12, 0x01, 0x02, 0x00, 9, 0x07, 0x00, 0x00, 0x34];

  List<int> bytes = systemNotificationBytes;
  IncomingMessage incomingMessage = BluetoothCommunicationService.getIncomingMessage(Uint8List.fromList(bytes));
  print(incomingMessage.displayMap);
}

void main() {
  runApp(MyApp());
//  parseTest();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Communication Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Communication Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String BLE_NAME = "ESP_COEX_BLE_DEMO";
  static const String BLE_SERVICE_UUID = "000000ff-0000-1000-8000-00805f9b34fb";
  static const String BLE_CHARACTERISTIC_UUID = "0000ff01-0000-1000-8000-00805f9b34fb";

  static const String BLT_NAME = "ESP_COEX_SPP_DEMO";
  static const String BLT_SERVICE_UUID = "00001101-0000-1000-8000-00805f9b34fb";

  BluetoothAdapter bluetoothAdapter = BluetoothAdapter.instance;
  StreamController deviceSystemsStreamController = StreamController<DeviceSystem>.broadcast();

  Stream<DeviceSystem> get deviceSystemsStream => deviceSystemsStreamController.stream;
  List<DeviceSystem> deviceSystems = [];

  DeviceSystem connectedDeviceSystem;
  BLTConnection bltConnection;
  Stream<dynamic> incomingParsedStream;

  @override
  void initState() {
    super.initState();
    bluetoothAdapter
      ..onDiscoveryStart = () {
        print('onDiscoveryStart');
      }
      ..onDeviceDiscovered = (d) {
        print('onDeviceDiscovered: ${d.name}');
      }
      ..onDiscoveryCompleted = () {
        print('onDiscoveryCompleted');
      }
      ..onDiscoveryCanceled = () {
        print('onDiscoveryCanceled');
      };

    bluetoothAdapter
      ..onConnecting = (d) {
        print('onConnecting: ${d.name}');
      }
      ..onConnected = (d) {
        print('onConnected: ${d.name}');
      }
      ..onDisconnecting = (d) {
        print('onDisconnecting: ${d.name}');
      }
      ..onDisconnected = (d) {
        print('onDisconnected: ${d.name}');
      };
  }

  clearDeviceSystemList() {
    deviceSystems.forEach((deviceSystem) {
      deviceSystem.bleDevice?.stopListeningForEvents();
    });
    deviceSystems = [];
  }

  updateDeviceSystemList() {
    deviceSystemsStreamController.add(null);
  }

  startBleDiscovery() {
    clearDeviceSystemList();
    updateDeviceSystemList();
//    bluetoothAdapter.getAvailableDevices().forEach(
//      (BluetoothDevice device) {
//        print(device.name);
//        if (device.name == BLE_NAME) {
//          int i = deviceSystems.length;
//          DeviceSystem deviceSystem = DeviceSystem(
//            name: 'Cognyx(${i + 1})',
//            bleDevice: device,
//            status: DeviceSystemStatus.DISCONNECTED,
//            statusText: 'Disconnected',
//          );
//          deviceSystems.add(deviceSystem);
//          updateDeviceSystemList();
//        }
//      },
//    );

    bluetoothAdapter.startDiscovery().map((eventObj) => (eventObj.extra as BluetoothDevice)).forEach(
          (BluetoothDevice device) {
        if (device.name == BLE_NAME) {
          device.listenForEvents();
          int i = deviceSystems.length;
          DeviceSystem deviceSystem = DeviceSystem(
            name: 'Cognyx(${i + 1})',
            bleDevice: device,
            status: DeviceSystemStatus.DISCONNECTED,
            statusText: 'Disconnected',
          );
          deviceSystems.add(deviceSystem);
          updateDeviceSystemList();
        }
      },
    );

//    DeviceSystem deviceSystem = DeviceSystem(
//      name: 'Cognyx(1)',
//      bleDevice: BLEDevice(name: BLE_NAME, address: 'AA:BB:CC:DD:EE:GG'), /// !!!!!!!,
//      status: DeviceSystemStatus.DISCONNECTED,
//      statusText: 'Disconnected',
//    );
//    deviceSystems.add(deviceSystem);
//    updateDeviceSystemList();
  }

  startConnectionProcess(DeviceSystem deviceSystem) async {
    BLEDevice bleDevice = deviceSystem.bleDevice;

    deviceSystem.status = DeviceSystemStatus.CONNECTING;
    print('Connecting to BLE...');
    deviceSystem.statusText = 'Connecting to BLE...';
    updateDeviceSystemList();

    BLEConnection bleConnection = await bleDevice.connect();

    if (bleConnection != null) {
      print('Discovering BLE Services...');
      deviceSystem.statusText = 'Discovering BLE Services...';
      updateDeviceSystemList();
      await Future.delayed(Duration(milliseconds: 900));
      await bleConnection.discoverServices();

      print('Writing to characteristic...');
      deviceSystem.statusText = 'Writing to characteristic...';
      updateDeviceSystemList();

      BLEService service = bleConnection.services.firstWhere((service) => service.uuid == BLE_SERVICE_UUID, orElse: () => null);
      BLECharacteristic characteristic = service.characteristics.firstWhere((characteristic) => characteristic.uuid == BLE_CHARACTERISTIC_UUID, orElse: () => null);

      await bleConnection.write([53, 53, 53], characteristic);

      print('Waiting for BLE to shutdown...');
      deviceSystem.statusText = 'Waiting for BLE to shutdown...';
      updateDeviceSystemList();

      await bluetoothAdapter.connectionEventStream.firstWhere((eventObj) => eventObj.event == BluetoothEvent.DEVICE_DISCONNECTED);

      print('Discovering BLT Devices...');
      deviceSystem.statusText = 'Discovering BLT Devices...';
      updateDeviceSystemList();

      BLTDevice bltDevice = await bluetoothAdapter.startDiscovery()
          .map((eventObj) => eventObj.extra).firstWhere((device) => device.name == BLT_NAME, orElse: () => null);

//      BLTDevice bltDevice = BLTDevice(name: BLT_NAME, address: 'AA:BB:CC:DD:EE:FF'); /// !!!!!!!

      print('Discovering BLT Services...');
      deviceSystem.statusText = 'Discovering BLT Services...';
      updateDeviceSystemList();

      deviceSystem.bltDevice = bltDevice;

      BLTService bltService = await bltDevice.fetchServices().then((services) => services.firstWhere((service) => service.uuid == BLT_SERVICE_UUID, orElse: () => null));
      print(bltService.uuid);
//      BLTService bltService = BLTService(device: bltDevice, uuid: BLT_SERVICE_UUID); /// !!!!!!!

      print('Connecting to BLT...');
      deviceSystem.statusText = 'Connecting to BLT...';
      updateDeviceSystemList();

      bltConnection = await bltService.connect();

      if (bltConnection != null) {
        deviceSystem.status = DeviceSystemStatus.CONNECTED;
        print('Connected...');
        deviceSystem.statusText = 'Connected';
        updateDeviceSystemList();

        connectedDeviceSystem = deviceSystem;

        setState(() {
          incomingParsedStream = bltConnection.readStream.map((bytes) {
            print('bytes: $bytes');
            return BluetoothCommunicationService
                .getIncomingMessage(Uint8List.fromList(bytes))
                ?.displayMap
                ?.toString() ?? bytes.toString();
          }).where((s) {
            return s != null;
          });
        });
      }
      else {
        disconnectBLE(deviceSystem);
      }
    }
    return;
  }

  disconnectBLE(DeviceSystem deviceSystem) {
    deviceSystem.bleDevice.disconnect();
    deviceSystems.removeWhere((_deviceSystem) => _deviceSystem.bltDevice.address == deviceSystem.bltDevice.address);
    updateDeviceSystemList();
  }

  disconnectBLT(DeviceSystem deviceSystem) {
//    deviceSystem.bltDevice.connectedService.disconnect();
    bltConnection.close();
    deviceSystem.bleDevice?.stopListeningForEvents();
    deviceSystems.removeWhere((_deviceSystem) => _deviceSystem.bltDevice.address == deviceSystem.bltDevice.address);
    updateDeviceSystemList();
  }

  @override
  Widget build(BuildContext context) {
    double screenAvailableWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double appBarHeight = AppBar().preferredSize.height;
    double screenAvailableHeight = screenHeight - statusBarHeight - appBarHeight;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ResponsiveGrid(
          width: screenAvailableWidth,
          height: screenAvailableHeight,
          borderData: BorderSide(width: 1, color: Theme.of(context).textTheme.body1.color),
          child: ResponsiveColumn(
            (w, h, r) => [RelativeSizeSegment(rel: 1)],
            children: [
              /// ############################################################################################
              /// ##################################### Relevant Devices #####################################
              /// ############################################################################################

              ResponsiveRow(
                (w, h, r) => [RelativeSizeSegment(rel: 0.2)],
                widget: (w, h, r) => Column(
                  children: [
                    Container(
                      height: screenAvailableHeight * 0.05,
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.deepPurpleAccent,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Relevant devices',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                bluetoothAdapter.stopDiscovery();
                                startBleDiscovery();
                              },
                              child: Icon(
                                Icons.refresh,
                                color: Colors.white,
                                size: screenAvailableHeight * 0.04,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: StreamBuilder(
                        stream: deviceSystemsStream,
                        builder: (context, snapshot) => Container(
                          width: w,
                          height: h * 0.7,
                          child: ListView.separated(
                            itemCount: deviceSystems.length,
                            itemBuilder: (context, i) {
                              DeviceSystem deviceSystem = deviceSystems[i];
                              bool isDisconnected = deviceSystem.status == DeviceSystemStatus.DISCONNECTED;
                              bool isConnected = deviceSystem.status == DeviceSystemStatus.CONNECTED;

//                    Color activeColor = Color.fromRGBO(74, 74, 74, 1);
//                    Color inActiveColor = Color.fromRGBO(74, 74, 74, 0.3);
//                    bool isIdle = _BLEService.isPhase(ConnectionPhase.DISCONNECTED);
//                    bool isSelected = !_BLEService.isPhase(ConnectionPhase.DISCONNECTED) && _BLEService.isSelected(device);
//                    bool isConnected = _BLEService.isPhase(ConnectionPhase.CONNECTED) && _BLEService.isConnected(device);
//                    Color color = (isIdle || isSelected) ? activeColor : inActiveColor;
//                    String text = isSelected ? isConnected ? 'Connected' : 'Connecting...' : 'Disconnected';

                              return InkWell(
                                onTap: () async {
                                  if (isDisconnected) {
                                    await bluetoothAdapter.stopDiscovery();
                                    startConnectionProcess(deviceSystem);
                                  } else if (isConnected) {
                                    disconnectBLT(deviceSystem);
                                  }
                                },
                                child: Container(
                                  width: w,
                                  height: h * 0.3,
                                  color: Color.fromRGBO(200, 20, 44, 0.1),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: w * 0.9,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(deviceSystem.name),
                                          Text(deviceSystem.statusText),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, i) {
//                    BluetoothDevice device = _availableDevices[i];
//                    BluetoothDevice nextDevice = (i < _availableDevices.length - 1) ? _availableDevices[i + 1] : null;
//                    Color activeColor = Color.fromRGBO(74, 74, 74, 1);
//                    Color inActiveColor = Color.fromRGBO(74, 74, 74, 0.3);
//                    bool isIdle = _BLEService.isPhase(ConnectionPhase.DISCONNECTED);
//                    bool isSelected = !_BLEService.isPhase(ConnectionPhase.DISCONNECTED) && (_BLEService.isSelected(device) || _BLEService.isSelected(nextDevice));
//                    Color color = (isIdle || isSelected) ? activeColor : inActiveColor;
                              return Divider(color: Colors.blue, thickness: 1, height: 5);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// ############################################################################################
              /// ####################################### Commands ###########################################
              /// ############################################################################################

              ResponsiveRow(
                (w, h, r) => [RelativeSizeSegment(rel: 0.4)],
                widget: (w, h, r) => Column(
                  children: [
                    Container(
                      height: screenAvailableHeight * 0.05,
                      color: Colors.deepPurpleAccent,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Commands',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: w * 0.1,
                          children: [
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = GetBatteryCommand();
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('GET_BATTERY_LEVEL'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = StartSessionCommand(
                                    userID: 'abcd\0',
                                    inputChannels: [
                                      InputChannel(
                                        channelNum: 0,
                                        channelName: 'aaa',
                                        gain: true,
                                        srb2: true,
                                        mux: 7,
                                        liveData: true,
                                      ),
                                      InputChannel(
                                        channelNum: 1,
                                        channelName: 'aaa',
                                        gain: true,
                                        srb2: true,
                                        mux: 7,
                                        liveData: true,
                                      ),
                                      InputChannel(
                                        channelNum: 2,
                                        channelName: 'aaa',
                                        gain: true,
                                        srb2: true,
                                        mux: 7,
                                        liveData: true,
                                      ),
                                      InputChannel(
                                        channelNum: 3,
                                        channelName: 'aaa',
                                        gain: true,
                                        srb2: true,
                                        mux: 7,
                                        liveData: true,
                                      ),
                                      InputChannel(
                                        channelNum: 4,
                                        channelName: 'aaa',
                                        gain: true,
                                        srb2: true,
                                        mux: 7,
                                        liveData: true,
                                      ),
                                      InputChannel(
                                        channelNum: 5,
                                        channelName: 'aaa',
                                        gain: true,
                                        srb2: true,
                                        mux: 7,
                                        liveData: true,
                                      ),
                                      InputChannel(
                                        channelNum: 6,
                                        channelName: 'aaa',
                                        gain: true,
                                        srb2: true,
                                        mux: 7,
                                        liveData: true,
                                      ),
                                      InputChannel(
                                        channelNum: 7,
                                        channelName: 'aaa',
                                        gain: true,
                                        srb2: true,
                                        mux: 7,
                                        liveData: true,
                                      )
                                    ],
                                    analysisConfiguration: AnalysisConfiguration(
                                      activeModules: [true, false, false, false, false],
                                      analysisInterval: 32,
                                      analysisBuffer: 5,
                                    ),
                                    sampleRate: SampleRate.SAMPLE_RATE_250,
                                    triggeredStimulations: [
                                      TriggeredStimulation(
                                          startTriggerType: TriggerType.TRIGGER_TYPE_TIME,
                                          startTrigger: TimeTrigger(delay: Duration(seconds: 5)),
                                          stopTriggerType: TriggerType.TRIGGER_TYPE_EVENT,
                                          stopTrigger: EventTrigger(event: AnalyzerEvent.ANALYSIS_EVENT_TEST),
                                          minStartTime: Duration(seconds: 3),
                                          maxStartTime: Duration(seconds: 5),
                                          stimulation: Stimulation(
                                              frequency1Type: StimulationFrequencyType.STIMULATION_FREQUENCY_TYPE_PARAMETER,
                                              frequency1: AnalysisParameterFrequency(
                                                parameter: AnalysisParameter.ANALYSIS_PARAMETER_DOMINANT_BETA,
                                              ),
                                              frequency2Type: StimulationFrequencyType.STIMULATION_FREQUENCY_TYPE_NUMBER,
                                              frequency2: NumberFrequency(
                                                frequency: 2000,
                                              ),
                                              strengthIncreaseInterval: 3,
                                              maxStrengthPercentage: 100,
                                              control: true,
                                              controlConfiguration: StimulationControlConfiguration(
                                                maxCurrent: 30,
                                                contactThreshold: 100,
                                                controlCalcInterval: 5,
                                              ))),
                                      TriggeredStimulation(
                                          startTriggerType: TriggerType.TRIGGER_TYPE_TIME,
                                          startTrigger: TimeTrigger(delay: Duration(seconds: 5)),
                                          stopTriggerType: TriggerType.TRIGGER_TYPE_EVENT,
                                          stopTrigger: EventTrigger(event: AnalyzerEvent.ANALYSIS_EVENT_TEST),
                                          minStartTime: Duration(seconds: 3),
                                          maxStartTime: Duration(seconds: 5),
                                          stimulation: Stimulation(
                                              frequency1Type: StimulationFrequencyType.STIMULATION_FREQUENCY_TYPE_PARAMETER,
                                              frequency1: AnalysisParameterFrequency(
                                                parameter: AnalysisParameter.ANALYSIS_PARAMETER_DOMINANT_BETA,
                                              ),
                                              frequency2Type: StimulationFrequencyType.STIMULATION_FREQUENCY_TYPE_NUMBER,
                                              frequency2: NumberFrequency(
                                                frequency: 2000,
                                              ),
                                              strengthIncreaseInterval: 3,
                                              maxStrengthPercentage: 100,
                                              control: true,
                                              controlConfiguration: StimulationControlConfiguration(
                                                maxCurrent: 30,
                                                contactThreshold: 100,
                                                controlCalcInterval: 5,
                                              ))),
                                      TriggeredStimulation(
                                          startTriggerType: TriggerType.TRIGGER_TYPE_TIME,
                                          startTrigger: TimeTrigger(delay: Duration(seconds: 5)),
                                          stopTriggerType: TriggerType.TRIGGER_TYPE_EVENT,
                                          stopTrigger: EventTrigger(event: AnalyzerEvent.ANALYSIS_EVENT_TEST),
                                          minStartTime: Duration(seconds: 3),
                                          maxStartTime: Duration(seconds: 5),
                                          stimulation: Stimulation(
                                              frequency1Type: StimulationFrequencyType.STIMULATION_FREQUENCY_TYPE_PARAMETER,
                                              frequency1: AnalysisParameterFrequency(
                                                parameter: AnalysisParameter.ANALYSIS_PARAMETER_DOMINANT_BETA,
                                              ),
                                              frequency2Type: StimulationFrequencyType.STIMULATION_FREQUENCY_TYPE_NUMBER,
                                              frequency2: NumberFrequency(
                                                frequency: 2000,
                                              ),
                                              strengthIncreaseInterval: 3,
                                              maxStrengthPercentage: 100,
                                              control: true,
                                              controlConfiguration: StimulationControlConfiguration(
                                                maxCurrent: 30,
                                                contactThreshold: 100,
                                                controlCalcInterval: 5,
                                              )))
                                    ],
                                    sessionDuration: Duration(seconds: 60),
                                    liveDataOnly: false,
                                    liveDataConfiguration: LiveDataConfiguration(
                                      systemLogsEnabled: true,
                                      stimulationLogsEnabled: true,
                                      analyzerDataEnabled: true,
                                      liveSensorDataEnabled: true,
                                      liveSensorConfiguration: LiveSensorConfiguration(
                                        sensorsDataAveragingNum: 5,
                                        sensorsDataBlockSize: 10,
                                      ),
                                    ),
                                    isSensorDataStored: true,
                                    storageConfiguration: StorageConfiguration(
                                      saveAveraging: 10,
                                      saveStartTriggerType: TriggerType.TRIGGER_TYPE_TIME,
                                      saveStartTrigger: TimeTrigger(delay: Duration(seconds: 5)),
                                      saveStopTriggerType: TriggerType.TRIGGER_TYPE_EVENT,
                                      saveStopTrigger: EventTrigger(event: AnalyzerEvent.ANALYSIS_EVENT_TEST),
                                    ));
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('START_SESSION'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = SessionLiveDataUpdateCommand(
                                  analysis: true,
                                  sensors: true,
                                  stimulation: false,
                                  system: true,
                                );
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('SESSION_LIVE_DATA_UPDATE'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = StopSessionCommand();
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('STOP_SESSION '),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = StimulationStartCommand(
                                  stimulation: Stimulation(
                                      frequency1Type: StimulationFrequencyType.STIMULATION_FREQUENCY_TYPE_PARAMETER,
                                      frequency1: AnalysisParameterFrequency(parameter: AnalysisParameter.ANALYSIS_PARAMETER_DOMINANT_SIGMA),
                                      frequency2Type: StimulationFrequencyType.STIMULATION_FREQUENCY_TYPE_NUMBER,
                                      frequency2: NumberFrequency(frequency: 3000),
                                      strengthIncreaseInterval: 5,
                                      maxStrengthPercentage: 80,
                                      control: true,
                                      controlConfiguration: StimulationControlConfiguration(
                                        maxCurrent: 40,
                                        contactThreshold: 30,
                                        controlCalcInterval: 12,
                                      )),
                                  duration: Duration(seconds: 10),
                                );
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('STIMULATION_START'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = StimulationStopCommand();
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('STIMULATION_STOP'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = LiveDataStartCommand(
                                  config: LiveDataConfiguration(
                                    systemLogsEnabled: true,
                                    stimulationLogsEnabled: true,
                                    analyzerDataEnabled: true,
                                    liveSensorDataEnabled: true,
                                    liveSensorConfiguration: LiveSensorConfiguration(
                                      sensorsDataAveragingNum: 5,
                                      sensorsDataBlockSize: 10,
                                    ),
                                  ),
                                  inputChannels: [
                                    InputChannel(
                                      channelNum: 0,
                                      channelName: 'aaa',
                                      gain: true,
                                      srb2: true,
                                      mux: 7,
                                      liveData: true,
                                    ),
                                    InputChannel(
                                      channelNum: 1,
                                      channelName: 'aaa',
                                      gain: true,
                                      srb2: true,
                                      mux: 7,
                                      liveData: true,
                                    ),
                                    InputChannel(
                                      channelNum: 2,
                                      channelName: 'aaa',
                                      gain: true,
                                      srb2: true,
                                      mux: 7,
                                      liveData: true,
                                    ),
                                    InputChannel(
                                      channelNum: 3,
                                      channelName: 'aaa',
                                      gain: true,
                                      srb2: true,
                                      mux: 7,
                                      liveData: true,
                                    )
                                  ],
                                );
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('LIVE_DATA_START'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = LiveDataUpdateCommand(
                                  config: LiveDataControl(
                                    sensors: true,
                                    stimulation: false,
                                    system: true,
                                  ),
                                );
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('LIVE_DATA_UPDATE'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = LiveDataStopCommand();
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('LIVE_DATA_STOP'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = GetUserSessionListCommand(user: UserName(name: '11223344'));
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('GET_USER_SESSION_LIST'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = DeleteSessionCommand(user: UserName(name: '11223344'), sessionID: 12);
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('DELETE_SESSION'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = GetSessionFileCommand(
                                  user: UserName(name: '11223344'),
                                  sessionID: 12,
                                  fileType: SessionFileType.SENSOR,
                                );
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('GET_SESSION_FILE'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = GetSystemLogFileCommand();
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('GET_SYSTEM_LOG_FILE'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = UpdateImageCommand(size: 100, crc: 12);
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('UPDATE_IMAGE'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = AbortCommand();
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('ABORT'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = DataChunkCommand(
                                  chunkID: 30,
                                  chunk: [1,2,3,4,5,6,7,8,9,8,7,6,5,4,3,2,1],
                                );
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('DATA_CHUNK'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = TransmitNextChunkCommand();
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('TRANSMIT_NEXT_CHUNK'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = RetransmitDataChunkCommand();
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('RETRANSMIT_DATA_CHUNK'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = GetUserListCommand();
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('GET_USER_LIST'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = DeleteUserCommand(user: UserName(name: '11223344'));
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('DELETE_USER'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = GetVersionCommand();
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('GET_VERSION'),
                            ),
                            FlatButton(
                              color: Colors.lime,
                              onPressed: () async {
                                Command command = SoftwareResetCommand();
                                BluetoothCommunicationService.sendCommand(command, bltConnection);
                              },
                              child: Text('SOFTWARE_RESET'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// ############################################################################################
              /// ############################### Responses/Notifications ####################################
              /// ############################################################################################

              ResponsiveRow(
                (w, h, r) => [RelativeSizeSegment(rel: 0.4)],
                widget: (w, h, r) => Column(
                  children: [
                    Container(
                      height: screenAvailableHeight * 0.05,
                      color: Colors.deepPurpleAccent,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Responses/Notifications',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                    child: StreamBuilder(
                      stream: incomingParsedStream,
                      initialData: 'placeHolder',
                      builder: (context, snapshot) {
                        return Align(
                            alignment: Alignment.center,
                            child: Text(snapshot.data),
                        );
                      },
                    ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
