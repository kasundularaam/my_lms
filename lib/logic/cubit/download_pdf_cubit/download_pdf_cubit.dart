import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/data/repositories/repository.dart';

part 'download_pdf_state.dart';

class DownloadPdfCubit extends Cubit<DownloadPdfState> {
  DownloadPdfCubit() : super(DownloadPdfInitial());

  void downloadPdf({required String path}) {
    try {
      Repository.downloadPdf(path: path);
    } catch (e) {
      throw e.toString();
    }
  }
}
