import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagconnectweb/constant/color_constant.dart';
import 'package:tagconnectweb/models/barangay_model.dart';
import 'package:tagconnectweb/services/barangay_service.dart';

class BarangayScreen extends StatefulWidget {
  const BarangayScreen({super.key});

  @override
  State<BarangayScreen> createState() => _BarangayScreenState();
}

class _BarangayScreenState extends State<BarangayScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _districtFocus = FocusNode();
  final FocusNode _contactFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  BarangayModel barangayModel =
      BarangayModel(name: '', district: 0, contact: '', address: '');
  bool isLoading = false;

  Future<void> fetchBarangay() async {
    try {
      final barangayService = BarangayService();
      final BarangayModel fetchData = await barangayService.getbarangayInfo();
      if (mounted) {
        setState(() {
          barangayModel = fetchData;
          _nameController.text = fetchData.name ?? '';
          _districtController.text = fetchData.district.toString();
          _contactController.text = fetchData.contact ?? '';
          _addressController.text = fetchData.address ?? '';
        });
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }

  Future<void> updateBarangay(BarangayModel barangayModel, int id) async {
    final barangayService = BarangayService();
    try {
      final response = await barangayService.patchBarangay(barangayModel, id);
      if (response) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        print('Updated');
      } else {
        print('Not Updated');
      }
    } catch (e) {
      throw Exception('Failed to update barangay: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchBarangay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tcAsh,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 700.w,
          height: 500.h,
          decoration: BoxDecoration(
            color: tcWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${barangayModel.name?.toUpperCase() ?? ''} BARANGAY INFORMATION',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: tcBlack,
                                  fontFamily: 'PublisSans',
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.name,
                                controller: _nameController,
                                focusNode: _nameFocus,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: tcBlack,
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Barangay Name',
                                  labelStyle: TextStyle(
                                    fontFamily: 'PublicSans',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  errorMaxLines: 2,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.w,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: tcBlack,
                                      width: 1.w,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: tcViolet,
                                      width: 2.w,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: tcRed,
                                      width: 2.w,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: tcGray,
                                      width: 2.w,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.name,
                                controller: _districtController,
                                focusNode: _districtFocus,
                                textAlign: TextAlign.start,
                                maxLength: 2,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: tcBlack,
                                ),
                                decoration: InputDecoration(
                                  counterText: '',
                                  labelText: 'District',
                                  labelStyle: TextStyle(
                                    fontFamily: 'PublicSans',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  errorMaxLines: 2,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.w,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: tcBlack,
                                      width: 1.w,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: tcViolet,
                                      width: 2.w,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: tcRed,
                                      width: 2.w,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: tcGray,
                                      width: 2.w,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.transparent,
                        ),
                        Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            color: tcViolet,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              barangayModel.image ?? '',
                              width: 350.w,
                              height: 350.w,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return Icon(
                                  Icons.error,
                                  color: tcWhite,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _contactController,
                      focusNode: _contactFocus,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: tcBlack,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Contact',
                        labelStyle: TextStyle(
                          fontFamily: 'PublicSans',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        errorMaxLines: 2,
                        hintText: 'Enter your phonenumber',
                        hintStyle: TextStyle(
                          fontFamily: 'PublicSans',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: tcGray,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: tcBlack,
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: tcViolet,
                            width: 2.w,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: tcRed,
                            width: 2.w,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: tcGray,
                            width: 2.w,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      controller: _addressController,
                      focusNode: _addressFocus,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: tcBlack,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(
                          fontFamily: 'PublicSans',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        errorMaxLines: 2,
                        hintText: 'Enter your address',
                        hintStyle: TextStyle(
                          fontFamily: 'PublicSans',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: tcGray,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: tcBlack,
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: tcViolet,
                            width: 2.w,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: tcRed,
                            width: 2.w,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: tcGray,
                            width: 2.w,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            if (mounted) {
                              setState(() {
                                isLoading = true;
                              });
                            }
                            final BarangayModel modelBarangay = BarangayModel(
                                id: barangayModel.id,
                                name: _nameController.text,
                                district: int.parse(_districtController.text),
                                contact: _contactController.text,
                                address: _addressController.text);
                            updateBarangay(modelBarangay, barangayModel.id!);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tcViolet,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            'Update',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'PublicSans',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: tcWhite,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
