import 'dart:async';
import 'dart:io';
import 'package:base_cubit_widget/base_cubit_widget.dart';
import 'package:calculator/app/product/component/record_button/model/record_button_initial_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class RecordButtonController extends BaseCubit<RecordButtonInitialModel, Object,
    Object> {
  RecordButtonController(
    this.onResult,
  ) : super(
          BaseState.initial(),
        );

  final void Function(File)? onResult;

  late final AudioRecorder _audioRecorder;

  @override
  Future<void> onInit() async {
    final status = await Permission.microphone.request();

    if (status == PermissionStatus.granted) {
      print('izin verilmiş');
    }

    _audioRecorder = AudioRecorder();
    emit(
      BaseState.initial(
        data: BaseInitialDataModel(
          data: RecordButtonInitialModel(),
        ),
      ),
    );
  }

  Future<void> startListening() async {
    String filePath = await getApplicationDocumentsDirectory()
        .then((value) => '${value.path}/gptAudio.wav');

    emit(
      BaseState.initial(
        data: initialData!.copyWith(
          data: initialModel!.copyWith(
            isListening: true,
          ),
        ),
      ),
    );

    await _audioRecorder.start(
      const RecordConfig(
        encoder: AudioEncoder.wav,
      ),
      path: filePath,
    );
  }

  Future<void> stopListening() async {
    final path = await _audioRecorder.stop();

    emit(
      BaseState.initial(
        data: initialData!.copyWith(
          data: initialModel!.copyWith(
            isListening: false,
          ),
        ),
      ),
    );

    if (path != null) {
      final file = File(path);
      onResult?.call(file);
    }
  }
}
