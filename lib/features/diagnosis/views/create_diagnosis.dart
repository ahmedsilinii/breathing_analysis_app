import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateDiagnosisScreen extends ConsumerStatefulWidget {
    const CreateDiagnosisScreen({super.key});

    @override
    ConsumerState<CreateDiagnosisScreen> createState() => _CreateDiagnosisScreenState();
}

class _CreateDiagnosisScreenState extends ConsumerState<CreateDiagnosisScreen> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Create Diagnosis'),
            ),
            body: Center(
                child: const Text('Create Diagnosis Screen Content'),
            ),
        );
    }
}