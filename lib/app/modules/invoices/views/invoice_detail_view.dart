import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medi/app/core/custom_widgets/global_appbar.dart';
import '../../../core/style/app_colors.dart';
import '../../../data/remote/model/invoices/invoice_response.dart';

class InvoiceDetailView extends StatelessWidget {
  final Invoice invoice;

  const InvoiceDetailView({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalUSD = invoice.details?.fold(
          0.0,
          (sum, detail) =>
              sum +
              (((detail.price ?? 0) * (detail.qty ?? 0)) /
                  (invoice.exchangeRate ?? 1)),
        ) ??
        0.0;

    double consumptionTaxAmount = 0.0;
    List<Map<String, dynamic>> otherTaxAmounts = [];
    if (invoice.tax != null) {
      if (invoice.tax?.consumptionTax != null &&
          invoice.tax!.consumptionTax! > 0) {
        consumptionTaxAmount = totalUSD * (invoice.tax!.consumptionTax! / 100);
      }
      if (invoice.tax?.otherTaxes != null) {
        for (final otherTax in invoice.tax!.otherTaxes!) {
          if (otherTax.percent != null && otherTax.percent! > 0) {
            otherTaxAmounts.add({
              'name': otherTax.name ?? 'Other Tax',
              'amount': totalUSD * (otherTax.percent! / 100),
              'percent': otherTax.percent,
            });
          }
        }
      }
    }
    final totalWithTax = totalUSD +
        consumptionTaxAmount +
        otherTaxAmounts.fold(
          0.0,
          (sum, tax) => sum + (tax['amount'] as double),
        );

    return Scaffold(
      appBar: globalAppBar(context, 'invoice_details'.tr),
      backgroundColor: AppColors.primaryAccentColor.withOpacity(0.05),
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.fileInvoice,
                      color: AppColors.primaryAccentColor,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      invoice.hospitalDetails?.hospitalName ??
                          'hospital_name'.tr,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'invoice_date'.tr + ': ${_formatDate(invoice.createdAt)}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                _buildInfoRow(
                  'patient'.tr,
                  '${invoice.patientDetails?.firstName ?? ''} ${invoice.patientDetails?.lastName ?? ''}',
                ),
                _buildInfoRow(
                  'doctor'.tr,
                  'Dr. ${invoice.doctorDetails?.fullName ?? 'N/A'}',
                ),
                const SizedBox(height: 24),
                _buildServicesTable(invoice),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryAccentColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'total'.tr + ': \$${totalWithTax.toStringAsFixed(2)} USD',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryAccentColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Action Button (commented out)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesTable(Invoice invoice) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'service'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                'qty'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                'price_usd'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                'total_usd'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const Divider(),
        ...?invoice.details?.map((detail) {
          final priceUSD = (detail.price ?? 0) / (invoice.exchangeRate ?? 1);
          final totalUSDRow = (detail.price ?? 0) *
              (detail.qty ?? 0) /
              (invoice.exchangeRate ?? 1);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Expanded(child: Text(detail.name ?? 'service'.tr)),
                Expanded(
                  child: Text(
                    '${detail.qty ?? 0}',
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    '\$${priceUSD.toStringAsFixed(2)}',
                    textAlign: TextAlign.right,
                  ),
                ),
                Expanded(
                  child: Text(
                    '\$${totalUSDRow.toStringAsFixed(2)}',
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        if (invoice.tax != null &&
            invoice.tax?.consumptionTax != null &&
            invoice.tax!.consumptionTax! > 0)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Expanded(child: Text('consumption_tax'.tr)),
                Expanded(child: Text('-', textAlign: TextAlign.center)),
                Expanded(child: Text('${invoice.tax!.consumptionTax}%')),
                Expanded(
                  child: Text(() {
                    final totalUSD = invoice.details?.fold(
                          0.0,
                          (sum, detail) =>
                              sum +
                              (((detail.price ?? 0) * (detail.qty ?? 0)) /
                                  (invoice.exchangeRate ?? 1)),
                        ) ??
                        0.0;
                    final taxAmount =
                        totalUSD * (invoice.tax!.consumptionTax! / 100);
                    return '\$${taxAmount.toStringAsFixed(2)}';
                  }(), textAlign: TextAlign.right),
                ),
              ],
            ),
          ),
        if (invoice.tax != null && invoice.tax?.otherTaxes != null)
          ...invoice.tax!.otherTaxes!
              .where((tax) => tax.percent != null && tax.percent! > 0)
              .map((tax) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(child: Text(tax.name ?? 'other_tax'.tr)),
                  Expanded(child: Text('-', textAlign: TextAlign.center)),
                  Expanded(child: Text('${tax.percent}%')),
                  Expanded(
                    child: Text(() {
                      final totalUSD = invoice.details?.fold(
                            0.0,
                            (sum, detail) =>
                                sum +
                                (((detail.price ?? 0) * (detail.qty ?? 0)) /
                                    (invoice.exchangeRate ?? 1)),
                          ) ??
                          0.0;
                      final taxAmount = totalUSD * (tax.percent! / 100);
                      return '\$${taxAmount.toStringAsFixed(2)}';
                    }(), textAlign: TextAlign.right),
                  ),
                ],
              ),
            );
          }).toList(),
      ],
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return 'N/A';
    }
  }
}
