import 'package:flutter/material.dart';
import 'package:flutter_resume_template/flutter_resume_template.dart';
import 'package:flutter_resume_template/src/components/section_bio_container.dart';
import 'package:flutter_resume_template/src/components/section_bottom_buttons.dart';
import 'package:flutter_resume_template/src/components/section_rating_widget.dart';
import 'package:flutter_resume_template/src/components/section_shaking.dart';
import 'package:flutter_resume_template/src/utils/typedef_utils.dart';

/// A stateful widget that provides a resume template designed to look like a business curriculum vitae.
///
/// This widget, named LayoutBusiness, can be used to display personal information, work experience, education, and other
/// relevant details in a professional format suitable for job applications and career-oriented websites. The template
/// includes a header section with the user's name and contact information, a summary section highlighting key skills and
/// qualifications, and sections for listing work experience, education, and other achievements.
///
/// The widget is designed to be customizable, with options for adjusting font sizes, colors, and other visual elements to
/// match the user's branding or preferences. It also supports dynamic data binding, allowing users to easily update the
/// content of their resume without needing to modify the underlying widget code.
///
/// To use this widget, simply create an instance of LayoutBusiness and pass in the required parameters. The widget will
/// automatically render the resume template based on the provided data.

class LayoutBusiness extends StatefulWidget {
  const LayoutBusiness({
    super.key,
    this.onSaveResume,
    required this.mode,
    required this.data,
    required this.h,
    required this.w,
  });

  final double h;
  final double w;
  final TemplateData data;
  final TemplateMode mode;
  final SaveResume<GlobalKey>? onSaveResume;

  @override
  State<LayoutBusiness> createState() => _LayoutBusinessState();
}

class _LayoutBusinessState extends State<LayoutBusiness> {
  GlobalKey globalKey = GlobalKey();

  late bool enableEditingMode = true;

  late bool isDragged = false;

  late TransformationController _controller;

  late bool absorbing = false;

  @override
  void initState() {
    setMode();
    _controller = TransformationController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setMode() {
    switch (widget.mode) {
      case TemplateMode.onlyEditableMode:
        enableEditingMode = true;
        isDragged = false;
        absorbing = enableEditingMode && isDragged;
        break;
      case TemplateMode.readOnlyMode:
        enableEditingMode = false;
        isDragged = false;
        absorbing = true;
        break;
      case TemplateMode.shakeEditAndSaveMode:
        enableEditingMode = true;
        isDragged = false;
        absorbing = enableEditingMode && isDragged;
        break;
    }
  }

  void _save() {
    if (widget.onSaveResume != null &&
        widget.mode == TemplateMode.shakeEditAndSaveMode) {
      widget.onSaveResume!(globalKey);
      _controller.value = Matrix4.identity();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AbsorbPointer(
          absorbing: absorbing,
          child: InteractiveViewer(
            transformationController: _controller,
            panEnabled: false,
            boundaryMargin: EdgeInsets.all(Config.smallWidth),
            maxScale: Config.fourPx,
            child: Align(
              alignment: Alignment.topCenter,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  alignment: Alignment.centerRight,
                  height: widget.h < 670 ? widget.h * 1.2 : widget.h * 1.05,
                  width: widget.w < 400 ? widget.w : widget.w * 0.2,
                  constraints: BoxConstraints(
                    minWidth: widget.w < 400 ? widget.w * 1.2 : widget.w * 1,
                    minHeight: widget.h < 670 ? widget.h * 1.2 : widget.h * 0.5,
                    maxHeight: double.maxFinite,
                    maxWidth: double.maxFinite,
                  ),
                  child: RepaintBoundary(
                    key: globalKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Config.dtHorPad.padding.horizontal,
                          vertical: Config.tenPx),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AnimatedShakingBuilder(
                                    autoPlay: isDragged,
                                    child: DisplayText(
                                      maxFontSize: 20,
                                      text: widget.data.fullName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                    ),
                                  ),
                                  AnimatedShakingBuilder(
                                    autoPlay: isDragged,
                                    child: DisplayText(
                                      maxFontSize: 14,
                                      text: widget.data.currentPosition,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  AnimatedShakingBuilder(
                                    autoPlay: isDragged,
                                    child: DisplayText(
                                      maxFontSize: 14,
                                      text: widget.data.street,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  AnimatedShakingBuilder(
                                    autoPlay: isDragged,
                                    child: DisplayText(
                                      maxFontSize: 14,
                                      text: widget.data.address,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  AnimatedShakingBuilder(
                                    autoPlay: isDragged,
                                    child: DisplayText(
                                      maxFontSize: 14,
                                      text: widget.data.country,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  AnimatedShakingBuilder(
                                    autoPlay: isDragged,
                                    child: DisplayText(
                                      maxFontSize: 14,
                                      text: widget.data.phoneNumber,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                  AnimatedShakingBuilder(
                                    autoPlay: isDragged,
                                    child: DisplayText(
                                      maxFontSize: 14,
                                      text: widget.data.email,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Config.spaceBox(Config.mediumSpacer),
                          const SHDivider(),
                          Config.spaceBox(Config.smallSpacer),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedShakingBuilder(
                                autoPlay: isDragged,
                                child: SBContainer(
                                  child: DisplayText(
                                    maxFontSize: 16,
                                    text: 'Short bio',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ),
                              ),
                              AnimatedShakingBuilder(
                                autoPlay: isDragged,
                                child: SBContainer(
                                  child: DisplayText(
                                    text: widget.data.bio,
                                    maxFontSize: 14,
                                    maxLines: 10,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(height: 1.2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Config.spaceBox(Config.smallSpacer),
                          const SHDivider(),
                          Config.spaceBox(Config.smallSpacer),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedShakingBuilder(
                                autoPlay: isDragged,
                                child: DisplayText(
                                  maxFontSize: 16,
                                  text: 'Work Experience',
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                              ),
                              if (widget.data.experience != null &&
                                  widget.data.experience!.isNotEmpty)
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List<Widget>.generate(
                                        widget.data.experience!.length > 2
                                            ? 2
                                            : 1,
                                        (index) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AnimatedShakingBuilder(
                                                  autoPlay: isDragged,
                                                  child: DisplayText(
                                                    maxFontSize: 16,
                                                    text: widget
                                                        .data
                                                        .experience![index]
                                                        .experienceTitle,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayLarge,
                                                  ),
                                                ),
                                                Config.spaceBox(Config.fourPx),
                                                AnimatedShakingBuilder(
                                                  autoPlay: isDragged,
                                                  child: DisplayText(
                                                    maxFontSize: 14,
                                                    text: widget
                                                        .data
                                                        .experience![index]
                                                        .experienceLocation,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayLarge,
                                                  ),
                                                ),
                                                Config.spaceBox(Config.fourPx),
                                                AnimatedShakingBuilder(
                                                  autoPlay: isDragged,
                                                  child: DisplayText(
                                                    maxFontSize: 14,
                                                    text: widget
                                                        .data
                                                        .experience![index]
                                                        .experiencePeriod,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                ),
                                                AnimatedShakingBuilder(
                                                  autoPlay: isDragged,
                                                  child: DisplayText(
                                                    maxFontSize: 14,
                                                    text: widget
                                                        .data
                                                        .experience![index]
                                                        .experienceLocation,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                ),
                                                Config.spaceBox(Config.eightPx),
                                                AnimatedShakingBuilder(
                                                  autoPlay: isDragged,
                                                  child: SBContainer(
                                                    child: DisplayText(
                                                      text: widget
                                                          .data
                                                          .experience![index]
                                                          .experienceDescription,
                                                      maxLines: 5,
                                                      maxFontSize: 14,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium
                                                          ?.copyWith(
                                                              height: 1.2),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ))),
                            ],
                          ),
                          Config.spaceBox(Config.smallSpacer),
                          const SHDivider(),
                          Config.spaceBox(Config.smallSpacer),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AnimatedShakingBuilder(
                                autoPlay: isDragged,
                                child: DisplayText(
                                  maxFontSize: 16,
                                  text: 'Education',
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AnimatedShakingBuilder(
                                    autoPlay: isDragged,
                                    child: SBContainer(
                                      child: DisplayText(
                                        maxFontSize: 14,
                                        text: widget.data.education,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                      ),
                                    ),
                                  ),
                                  AnimatedShakingBuilder(
                                    autoPlay: isDragged,
                                    child: SBContainer(
                                      child: DisplayText(
                                        text: 'Bachelor Degree',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Config.spaceBox(Config.smallSpacer),
                          const SHDivider(),
                          Config.spaceBox(Config.smallSpacer),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AnimatedShakingBuilder(
                                autoPlay: isDragged,
                                child: DisplayText(
                                  maxFontSize: 16,
                                  text: 'Languages',
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                              ),
                            ],
                          ),
                          Config.spaceBox(Config.eightPx),
                          RatingWidget(
                            rating: 5,
                            title: 'English',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 15),
                            autoplay: isDragged,
                          ),
                          Config.spaceBox(Config.eightPx),
                          RatingWidget(
                            autoplay: isDragged,
                            rating: 3,
                            title: 'French',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 15),
                          ),
                          Config.spaceBox(Config.eightPx),
                          RatingWidget(
                            autoplay: isDragged,
                            rating: 1,
                            title: 'Russian',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (widget.mode == TemplateMode.shakeEditAndSaveMode)
          AnimateButton(
              onDragged: () => setState(
                    () {
                      _controller.value = Matrix4.identity();
                      isDragged = !isDragged;
                    },
                  ),
              onSave: _save,
              isDragged: isDragged)
      ],
    );
  }
}
